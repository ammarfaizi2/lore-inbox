Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265291AbUGMOzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUGMOzx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 10:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbUGMOzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 10:55:53 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:396 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S265291AbUGMOzu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 10:55:50 -0400
Message-Id: <200407131455.i6DEtmAo006203@localhost.localdomain>
To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
cc: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>,
       florin@sgi.com, linux-kernel@vger.kernel.org,
       albert@users.sourceforge.net
Subject: Re: [linux-audio-dev] Re: desktop and multimedia as an afterthought? 
In-reply-to: Your message of "Tue, 13 Jul 2004 13:09:28 BST."
             <008501c468d2$405d8c70$161b14ac@boromir> 
Date: Tue, 13 Jul 2004 10:55:48 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [141.151.61.237] at Tue, 13 Jul 2004 09:55:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Thus, the fact that Linux does not support protocols to prevent priority
>inversion (please correct me if I am wrong) kind of suggests that supporting
>realtime applications is not considered very important.

we went through this (you and i in particular) right here on LAD a
year or so ago. while i might agree with you about the priority given
to RT-ish apps, my recollection of the end of that discussion is that
priority inheritance is neither necessary nor sufficient to allow
adequate RT performance. priority inversion generally can be factored
out through application redesign, and the protocols i've seen to
address it are not useful for RT purposes - they just help deadlock.

--p
