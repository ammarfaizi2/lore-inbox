Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268255AbTGRQsX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271818AbTGRQql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:46:41 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:60105 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S271794AbTGRQpH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 12:45:07 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 18 Jul 2003 09:52:42 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Mike Galbraith <efault@gmx.de>
cc: Wiktor Wodecki <wodecki@gmx.net>, Nick Piggin <piggin@cyberone.com.au>,
       Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] O6int for interactivity
In-Reply-To: <5.2.1.1.2.20030718174433.01b12878@pop.gmx.net>
Message-ID: <Pine.LNX.4.55.0307180951050.5608@bigblue.dev.mcafeelabs.com>
References: <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net> <200307170030.25934.kernel@kolivas.org>
 <200307170030.25934.kernel@kolivas.org> <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net> <5.2.1.1.2.20030718174433.01b12878@pop.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003, Mike Galbraith wrote:

> Telling to not mess with my kernel threads seems to have fixed it here...
> no stalls during the whole contest run.  New contest numbers attached.

It is ok to use unfairness towards kernel threads to avoid starvation. We
control them. It is right to apply uncontrolled unfairness to userspace
tasks though.



- Davide

