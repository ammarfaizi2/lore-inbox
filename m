Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268409AbTGIQnt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 12:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268410AbTGIQns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 12:43:48 -0400
Received: from ns.suse.de ([213.95.15.193]:6919 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268409AbTGIQnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 12:43:46 -0400
Date: Wed, 9 Jul 2003 18:58:23 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Readd BUG for SMP TLB IPI
Message-Id: <20030709185823.1f243367.ak@suse.de>
In-Reply-To: <1057769607.6262.63.camel@dhcp22.swansea.linux.org.uk>
References: <20030709124915.3d98054b.ak@suse.de>
	<1057750022.6255.41.camel@dhcp22.swansea.linux.org.uk>
	<20030709134109.65efa245.ak@suse.de>
	<1057769607.6262.63.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 Jul 2003 17:53:28 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Mer, 2003-07-09 at 12:41, Andi Kleen wrote:
> > > We have recorded retransmitted IPI's on some boards (notably the
> > > infamous BP6). They do happen. Early 2.4 had a fix for handling the
> > > replay case too, but someone lost it and BP6 boards no longer work as
> > > reliably.
> > 
> > Ok, all non broken hardware.
> 
> It can happen to any PII/PIII box, its just very very rare on others, so
> rare I guess such crashes are in the noise.

How do you know it an happen on them? Do you have backtraces?

If the BUG was there they wouldn't be in the noise.  With the incomplete/broken
handling it's just a silent hang.

-Andi
