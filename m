Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVANDlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVANDlb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVANDjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:39:23 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:35008 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S261885AbVANDem
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 22:34:42 -0500
Message-Id: <200501140334.j0E3YPMv027069@localhost.localdomain>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       lkml@s2y4n2c.de, rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com,
       chrisw@osdl.org, mpm@selenic.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Fri, 14 Jan 2005 14:31:21 +1100."
             <1105673482.5402.58.camel@npiggin-nld.site> 
Date: Thu, 13 Jan 2005 22:34:25 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [141.152.253.251] at Thu, 13 Jan 2005 21:34:41 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I wouldn't have thought it is so much a matter of having real-time-ish
>scheduling available that tries to play nicely in a multi user machine.
>That must still imply that either the user is able to unduly tie up
>resources (and thus it has to be a privileged operation), or that it
>sometimes can't meet its "guarantees" (in which case, is it useful?).

most audio hackers and users are perfectly comfortable with the OSX
compromise - tasks with no special privilege get deterministic access
to the CPU as long as they do not consume excessive cycles.

this begs the question about what happens when the entire class of
SCHED_ISO (to use Con's working name for such a scheduling class)
tasks is eating too much CPU, rather than any one of them, but i'll
leave that to Con :)

--p
