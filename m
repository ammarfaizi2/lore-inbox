Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWGUWQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWGUWQh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 18:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWGUWQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 18:16:37 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:11140 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751235AbWGUWQg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 18:16:36 -0400
Message-ID: <1153519892.44c15114aff09@portal.student.luth.se>
Date: Sat, 22 Jul 2006 00:11:32 +0200
From: ricknu-0@student.ltu.se
To: Jeff Garzik <jeff@garzik.org>
Cc: Michael Buesch <mb@bu3sch.de>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC][PATCH] A generic boolean (version 2)
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153445087.44c02cdf40511@portal.student.luth.se> <Pine.LNX.4.61.0607211623270.28469@yvahk01.tjqt.qr> <200607212027.37823.mb@bu3sch.de> <44C1439C.20905@garzik.org>
In-Reply-To: <44C1439C.20905@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citerar Jeff Garzik <jeff@garzik.org>:

> Michael Buesch wrote:
> > On Friday 21 July 2006 16:23, Jan Engelhardt wrote:
> >>> The changes are:
> >>> * u2 has been corrected to u1 (and also added it as __u1)
> >> Do we really need this? Is not 'bool' enough?
> > 
> > I would say we don't even _want_ this.
> > A u1 variable will basically never be one bit wide.
> > It will be at least 8bit, or let's say 32bit. Maybe
> > even 64bit on some archs. It all depends on the compiler
> > plus the arch.
> > 
> > We _don't_ want u1, because we don't get what we see.
> 
> For this and 1000 other reasons, we don't want u1.

This is a classic "do what others have done (with some modifications) and not
give a thought about it"... it's gone!
