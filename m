Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267380AbUGNNei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267380AbUGNNei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 09:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267384AbUGNNeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 09:34:37 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:64990 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S267380AbUGNNeg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 09:34:36 -0400
Message-Id: <200407141334.i6EDYYLA009782@localhost.localdomain>
To: "Harish K Harshan" <harish@amritapuri.amrita.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time thread scheduling in linux?? 
In-reply-to: Your message of "Wed, 14 Jul 2004 18:01:05 +0530."
             <60580.203.197.150.195.1089808265.squirrel@203.197.150.195> 
Date: Wed, 14 Jul 2004 09:34:34 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [141.151.61.237] at Wed, 14 Jul 2004 08:34:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     I would like to know if there is any way to give a thread real-time
>priority under Linux, and also if it is possible using the pthread
>library. How would the kernel handle such threads? And do we need to
>implement locking systems, so that this thread does not block other
>threads permanently? Please help me, because I am working on a data
>acquisition application, and the acquisition thread needs almost
>real-time priority, and loss of data is not affordable.

wrong mailing list, sort of.

use google to look up SCHED_FIFO, which will lead you into the
wonderful of soft-RT programming on POSIX operating systems. 

lots of people (including me) do this sort of thing already. but be
warned: linux is not a hard-RT OS, and cannot become so. if you are
doing data acquisition for critical data or systems, you might want to
consider RT-Linux or RTAI or other hard-RT variants.

--p

