Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVANEpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVANEpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 23:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVANEpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 23:45:17 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:65513 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S261892AbVANEpM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 23:45:12 -0500
Message-Id: <200501140445.j0E4j94k001522@localhost.localdomain>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       lkml@s2y4n2c.de, rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com,
       chrisw@osdl.org, mpm@selenic.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Fri, 14 Jan 2005 15:23:58 +1100."
             <1105676638.5402.89.camel@npiggin-nld.site> 
Date: Thu, 13 Jan 2005 23:45:08 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [141.152.253.251] at Thu, 13 Jan 2005 22:45:11 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Alternatively, could you grant the required capabilities to use real
>RT scheduling and not foul up the scheduler?

this is precisely the point i was making. either you agree that
unprivileged users can get easy access to a scheduling class that can
reliably DOS the system, or they can't. if they can't, what kind of
scheduling class can they access easily?

according to andrew, and i agree with his conclusion, many people
agree that its OK for them to get access to the DOS class, but there's
little agreement on the security model to allow this. Con is
suggesting that they are not, but instead get a different scheduling
class that is functionally equivalent except that it can't
(theoretically) be used to DOS the system.

--p
