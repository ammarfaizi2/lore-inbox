Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263885AbUD0IEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbUD0IEq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 04:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263887AbUD0IEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 04:04:46 -0400
Received: from [203.14.152.115] ([203.14.152.115]:1807 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263885AbUD0IEo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 04:04:44 -0400
Date: Tue, 27 Apr 2004 18:02:21 +1000
To: Pavel Machek <pavel@suse.cz>, 234976@bugs.debian.org
Cc: Roland Stigge <stigge@antcom.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040427080221.GA17023@gondor.apana.org.au>
References: <E1B6on4-0005EW-00@gondolin.me.apana.org.au> <1080310299.2108.10.camel@atari.stigge.org> <20040326142617.GA291@elf.ucw.cz> <1080315725.2951.10.camel@atari.stigge.org> <20040326155315.GD291@elf.ucw.cz> <1080317555.12244.5.camel@atari.stigge.org> <20040326161717.GE291@elf.ucw.cz> <1080325072.2112.89.camel@atari.stigge.org> <20040426094834.GA4901@gondor.apana.org.au> <20040426130807.GL2595@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040426130807.GL2595@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 03:08:07PM +0200, Pavel Machek wrote:
> 
> What about switching to temporary, PSE-enabled pagetables
> in nosave area for suspend? Copying pagetables soon after boot
> should do the trick.

Yes that would solve the non-PSE problem as well.  Only problem
is that I don't have any more time to spend on this issue so one
of you guys will need to write the code.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
