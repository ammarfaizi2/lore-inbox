Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263972AbUD0K1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbUD0K1G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 06:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbUD0K1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 06:27:06 -0400
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:39040 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263972AbUD0K1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 06:27:02 -0400
Date: Tue, 27 Apr 2004 12:26:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nigel Cunningham <ncunningham@linuxmail.com>,
       Roland Stigge <stigge@antcom.de>, 234976@bugs.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040427102644.GC10593@elf.ucw.cz>
References: <1080317555.12244.5.camel@atari.stigge.org> <20040326161717.GE291@elf.ucw.cz> <1080325072.2112.89.camel@atari.stigge.org> <20040426094834.GA4901@gondor.apana.org.au> <20040426104015.GA5772@gondor.apana.org.au> <opr6193np1ruvnp2@laptop-linux.wpcb.org.au> <20040426131152.GN2595@openzaurus.ucw.cz> <1083048985.12517.21.camel@gaston> <20040427102127.GB10593@elf.ucw.cz> <20040427102344.GA24313@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427102344.GA24313@gondor.apana.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > BTW what is performance penalty of not running 4MB pages on kernel?
> > Every user with intel-agp (etc) eats it, even if they are not using 3D
> > on the machine...
> 
> The penalty only applies to the 4M region around the gatt table.

I thought that kernel should pretty much fit to single 4M region, but
I guess that's not case here. Thanks.

(Compiled kernel is still <4M, so having gatt near to kernel code
would hurt quite a bit; but that's probably not the case).
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
