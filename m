Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVGLIfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVGLIfC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 04:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVGLIc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 04:32:58 -0400
Received: from [203.171.93.254] ([203.171.93.254]:32715 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261262AbVGLIcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 04:32:22 -0400
Subject: Re: [PATCH] [33/48] Suspend2 2.1.9.8 for 2.6.12:
	610-encryption.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050710181555.GG10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164431243@foobar.com>
	 <20050710181555.GG10904@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121157245.13869.122.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Jul 2005 18:34:05 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'ello!

On Mon, 2005-07-11 at 04:15, Pavel Machek wrote:
> Hi!
> 
> > +/*
> > + * put_extent_chain.
> > + *
> > + * Frees a whole chain of extents.
> > + */
> > +void put_extent_chain(struct extentchain * chain)
> 
> This probably should be extent_chain.
> 
> > +#ifndef EXTENT_H
> > +#define EXTENT_H
> > +struct extentchain {
> > +	int size; /* size of the extent ie sum (max-min+1) */
> > +	int allocs;
> > +	int frees;
> > +	int debug;
> > +	int timesusedoptimisation;
> 
> time_suse_d_optimisation? ;-).

Fixed up!

Thanks, once again!

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

