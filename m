Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUD0K0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUD0K0d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 06:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbUD0K0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 06:26:32 -0400
Received: from [203.14.152.115] ([203.14.152.115]:58386 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263971AbUD0K0b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 06:26:31 -0400
Date: Tue, 27 Apr 2004 20:23:44 +1000
To: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nigel Cunningham <ncunningham@linuxmail.com>,
       Roland Stigge <stigge@antcom.de>, 234976@bugs.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040427102344.GA24313@gondor.apana.org.au>
References: <20040326155315.GD291@elf.ucw.cz> <1080317555.12244.5.camel@atari.stigge.org> <20040326161717.GE291@elf.ucw.cz> <1080325072.2112.89.camel@atari.stigge.org> <20040426094834.GA4901@gondor.apana.org.au> <20040426104015.GA5772@gondor.apana.org.au> <opr6193np1ruvnp2@laptop-linux.wpcb.org.au> <20040426131152.GN2595@openzaurus.ucw.cz> <1083048985.12517.21.camel@gaston> <20040427102127.GB10593@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427102127.GB10593@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 12:21:27PM +0200, Pavel Machek wrote:
> 
> BTW what is performance penalty of not running 4MB pages on kernel?
> Every user with intel-agp (etc) eats it, even if they are not using 3D
> on the machine...

The penalty only applies to the 4M region around the gatt table.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
