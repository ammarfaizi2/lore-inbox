Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161355AbWJKTaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161355AbWJKTaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161358AbWJKTaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:30:15 -0400
Received: from hera.kernel.org ([140.211.167.34]:21435 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1161355AbWJKTaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:30:14 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] Add carta_random32() library routine
Date: Wed, 11 Oct 2006 12:29:38 -0700
Organization: OSDL
Message-ID: <20061011122938.7e81f4bc@freekitty>
References: <200610111900.k9BJ01M4021853@hera.kernel.org>
	<452D4491.30806@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1160594978 8783 10.8.0.54 (11 Oct 2006 19:29:38 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 11 Oct 2006 19:29:38 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 15:22:57 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Linux Kernel Mailing List wrote:
> > commit e0ab2928cc2202f13f0574d4c6f567f166d307eb
> > tree 3df0b8e340b1a98cd8a2daa19672ff008e8fb7f9
> > parent b611967de4dc5c52049676c4369dcac622a7cdfe
> > author Stephane Eranian <eranian@hpl.hp.com> 1160554905 -0700
> > committer Linus Torvalds <torvalds@g5.osdl.org> 1160590461 -0700
> > 
> > [PATCH] Add carta_random32() library routine
> > 
> > This is a follow-up patch based on the review for perfmon2.  This patch
> > adds the carta_random32() library routine + carta_random32.h header file.
> > 
> > This is fast, simple, and efficient pseudo number generator algorithm.  We
> > use it in perfmon2 to randomize the sampling periods.  In this context, we
> > do not need any fancy randomizer.
> 
> hrm, does this really warrant inclusion into every kernel build, on 
> every platform?
> 
> 	Jeff
> 

Wouldn't existing net_random() work?

-- 
Stephen Hemminger <shemminger@osdl.org>
