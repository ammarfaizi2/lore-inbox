Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263969AbUD0KVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbUD0KVy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 06:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbUD0KVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 06:21:54 -0400
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:37504 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263969AbUD0KVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 06:21:52 -0400
Date: Tue, 27 Apr 2004 12:21:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nigel Cunningham <ncunningham@linuxmail.com>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Roland Stigge <stigge@antcom.de>, 234976@bugs.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040427102127.GB10593@elf.ucw.cz>
References: <1080315725.2951.10.camel@atari.stigge.org> <20040326155315.GD291@elf.ucw.cz> <1080317555.12244.5.camel@atari.stigge.org> <20040326161717.GE291@elf.ucw.cz> <1080325072.2112.89.camel@atari.stigge.org> <20040426094834.GA4901@gondor.apana.org.au> <20040426104015.GA5772@gondor.apana.org.au> <opr6193np1ruvnp2@laptop-linux.wpcb.org.au> <20040426131152.GN2595@openzaurus.ucw.cz> <1083048985.12517.21.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083048985.12517.21.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > re nuanced test? Better still, 
> > 
> > Test should still be there. Switching to temporary page tables
> > seems to be tbe solution.
> 
> This is close to the problem I talked about when that PPC version
> appeared, which is why, at least on resume, I run everything with
> MMU off in the patch I proposed :)

I'm not sure if I can turn off MMU on i386 so easily. That would
certainly fix it, too.

BTW what is performance penalty of not running 4MB pages on kernel?
Every user with intel-agp (etc) eats it, even if they are not using 3D
on the machine...
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
