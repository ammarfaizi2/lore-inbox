Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266766AbUF3QcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266766AbUF3QcH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 12:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266768AbUF3QcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 12:32:07 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:15067 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S266766AbUF3QcF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 12:32:05 -0400
Message-Id: <200406301632.i5UGW3Ai011182@localhost.localdomain>
To: Jakub Jelinek <jakub@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK 
In-reply-to: Your message of "Wed, 30 Jun 2004 11:26:52 EDT."
             <20040630152651.GW21264@devserv.devel.redhat.com> 
Date: Wed, 30 Jun 2004 12:32:03 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [141.152.253.159] at Wed, 30 Jun 2004 11:32:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>One thing to note is that NPTL defaults to PTHREAD_INHERIT_SCHED
>while LinuxThreads defaults to PTHREAD_EXPLICIT_SCHED.
>So, if you care about what scheduling created threads will have
>and want it to work with both NPTL and LinuxThreads, you want
>pthread_attr_setinheritsched (&attr, PTHREAD_*_SCHED);
>explicitely.

But since we always set the scheduling class explicitly, should the
inherited scheduler class make any difference?

--p
