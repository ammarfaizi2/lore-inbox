Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWFRNyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWFRNyp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 09:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWFRNyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 09:54:45 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:42395 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932234AbWFRNyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 09:54:44 -0400
Date: Sun, 18 Jun 2006 15:53:36 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: Joachim Fritschi <jfritschi@freenet.de>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH  1/4] Twofish cipher - split out common c code
In-Reply-To: <20060618113138.GA22097@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.64.0606181551580.17704@scrub.home>
References: <200606041516.21967.jfritschi@freenet.de> <200606080920.04480.jfritschi@freenet.de>
 <20060608072735.GA10613@gondor.apana.org.au> <200606161358.53036.jfritschi@freenet.de>
 <20060618113138.GA22097@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 18 Jun 2006, Herbert Xu wrote:

> > +config CRYPTO_TWOFISH_COMMON
> > +        tristate	
> > +        depends on CRYPTO
> > +        help
> > +	  Common parts of the Twofish cipher algorithm shared by the 
> > +	  generic c and the assembler implementations.
> 
> Please drop the help (it's not meant to be visible) and add a 'default n'
> instead.

The help text is also useful as documentation and doesn't hurt.
'n' is the default already, so it's not needed.

bye, Roman
