Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266555AbSLDNzH>; Wed, 4 Dec 2002 08:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266652AbSLDNzH>; Wed, 4 Dec 2002 08:55:07 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:21669 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266555AbSLDNzG>; Wed, 4 Dec 2002 08:55:06 -0500
Subject: Re: [patch]back ports ICH3M support into 2.4.20
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: hugang <hugang@soulinfo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, andrea@suse.de,
       jamagallon@able.es, marcelo@hera.kernel.org
In-Reply-To: <20021204210941.47b4db08.hugang@soulinfo.com>
References: <20021201130427.37a915bf.hugang@soulinfo.com>
	<1038765805.30381.3.camel@irongate.swansea.linux.org.uk> 
	<20021204210941.47b4db08.hugang@soulinfo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Dec 2002 14:36:48 +0000
Message-Id: <1039012608.15353.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-04 at 13:09, hugang wrote:
> > 2.4.20 already has the correct version of the fixes for partially
> > configured IDE devices. The code you are posting is old and in several
> > places wrong, hence it was removed.
> > 
> > 2.4.20 will try and do a full pci device setup, then fall back to just
> > configuring BAR4.
> > 
> > Alan
> > 
> Here is an new patch for it. But I'm not true that , Place the fixup function in pci_init_piix is good way. But it works.
> Here is it.

See what I said before. 2.4.20 already does a pci BAR4 fixup if needed.
Your change is still wrong.


