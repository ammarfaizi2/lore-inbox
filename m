Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWGVRJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWGVRJb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 13:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWGVRJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 13:09:31 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:38568 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1750975AbWGVRJb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 13:09:31 -0400
Message-ID: <1153588128.44c25ba03071c@portal.student.luth.se>
Date: Sat, 22 Jul 2006 19:08:48 +0200
From: ricknu-0@student.ltu.se
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [RFC][PATCH] A generic boolean (version 3)
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153524422.44c162c65c21b@portal.student.luth.se> <44C1BA4A.4070107@s5r6.in-berlin.de>
In-Reply-To: <44C1BA4A.4070107@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citerar Stefan Richter <stefanr@s5r6.in-berlin.de>:

> ricknu-0@student.ltu.se wrote:
> > * changed back the version-checking when defining bool, this since I'm
> quite
> > sure Linux 2.4 and 2.6 share (if not all, then large part of) the drivers.
> And
> > 2.4 is still compiled with the 2.95 Gcc.
> 
> Drivers in 2.4 and 2.6 differ. We don't put 2.4-compatibility code into 
> 2.6. And the bool type won't get into 2.4.

It doesn't?! Good, that simplify it to only a:
typedef _Bool bool;
line. Did googled on it but did not find anything that comfirmed or denied it.
Thanks

> -- 
> Stefan Richter

/Richard Knutsson

