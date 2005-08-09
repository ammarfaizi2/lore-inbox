Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVHIEQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVHIEQW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 00:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVHIEQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 00:16:22 -0400
Received: from mail24.sea5.speakeasy.net ([69.17.117.26]:4054 "EHLO
	mail24.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932440AbVHIEQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 00:16:21 -0400
Date: Tue, 9 Aug 2005 00:16:18 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Olaf Hering <olh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] add MODULE_ALIAS for x86_64 aes
In-Reply-To: <20050808201046.GB15425@suse.de>
Message-ID: <Pine.LNX.4.63.0508090015230.20178@excalibur.intercode>
References: <20050808173336.GA11503@suse.de> <20050808105109.5e3168fc.akpm@osdl.org>
 <20050808175520.GA12150@suse.de> <20050808201046.GB15425@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005, Olaf Hering wrote:

>  On Mon, Aug 08, Olaf Hering wrote:
> >  On Mon, Aug 08, Andrew Morton wrote:
> > 
> > > What do you mean by "this could be the right fix"?  Did it work?
> > 
> > I cant test it due to lack of hardware. Will find someone who does.
> > modprobe aes is done by openswan, works on ppc, i386, but not on x86_64.
> 
> This works, tested it. modprobe -v aes
> insmod /lib/modules/2.6.13-rc6-3-default/kernel/arch/x86_64/crypto/aes-x86_64.ko 

It looks the same as the i386 version, so probably ok.

(CC'd the crypto maintainer).


- James
-- 
James Morris
<jmorris@namei.org>
