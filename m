Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVAGPmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVAGPmZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 10:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVAGPmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 10:42:25 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:41423 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261464AbVAGPlm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:41:42 -0500
Message-Id: <200501071541.j07FfeQC018553@localhost.localdomain>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Christoph Hellwig <hch@infradead.org>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Fri, 07 Jan 2005 16:33:30 +0100."
             <20050107153328.GD28466@devserv.devel.redhat.com> 
Date: Fri, 07 Jan 2005 10:41:40 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.197.185.179] at Fri, 7 Jan 2005 09:41:41 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> well thats good, i hope someone updated the man page too :) 
>> 
>> but is there actually any way to grant specific users a reasonable
>> rlimit, 
>
>yes; most distributions will use pam for this, you can set per user or per
>gorup limits there.

isn't that a uid/gid based system? ok, i'm being a little snide :)

fine, so the mlock situation may have improved enough post-2.6.9 that
it can be considered fixed. that leaves the scheduler issue. but
apparently, a uid/gid solution is OK for mlock, and not for the
scheduler. am i missing something?

--p


