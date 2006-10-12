Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422779AbWJLHOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422779AbWJLHOQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422780AbWJLHOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:14:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422779AbWJLHOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:14:15 -0400
Date: Thu, 12 Oct 2006 00:07:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org, Stephane Eranian <eranian@hpl.hp.com>
Subject: Re: [PATCH] Add carta_random32() library routine
Message-Id: <20061012000749.be62f2e0.akpm@osdl.org>
In-Reply-To: <20061011122938.7e81f4bc@freekitty>
References: <200610111900.k9BJ01M4021853@hera.kernel.org>
	<452D4491.30806@garzik.org>
	<20061011122938.7e81f4bc@freekitty>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 12:29:38 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> On Wed, 11 Oct 2006 15:22:57 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
> > Linux Kernel Mailing List wrote:
> > > commit e0ab2928cc2202f13f0574d4c6f567f166d307eb
> > > tree 3df0b8e340b1a98cd8a2daa19672ff008e8fb7f9
> > > parent b611967de4dc5c52049676c4369dcac622a7cdfe
> > > author Stephane Eranian <eranian@hpl.hp.com> 1160554905 -0700
> > > committer Linus Torvalds <torvalds@g5.osdl.org> 1160590461 -0700
> > > 
> > > [PATCH] Add carta_random32() library routine
> > > 
> > > This is a follow-up patch based on the review for perfmon2.  This patch
> > > adds the carta_random32() library routine + carta_random32.h header file.
> > > 
> > > This is fast, simple, and efficient pseudo number generator algorithm.  We
> > > use it in perfmon2 to randomize the sampling periods.  In this context, we
> > > do not need any fancy randomizer.
> > 
> > hrm, does this really warrant inclusion into every kernel build, on 
> > every platform?
> > 
> > 	Jeff
> > 
> 
> Wouldn't existing net_random() work?
> 

It might do, but someone went and hid it in networking and nobody knew
about it.

Stephane?
