Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTFZS7j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 14:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTFZS4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 14:56:53 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:4365 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S262383AbTFZS4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 14:56:42 -0400
Date: Thu, 26 Jun 2003 21:10:49 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Matthew Wilcox <willy@debian.org>
cc: David Woodhouse <dwmw2@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BINFMT_ZFLAT can't be a module
In-Reply-To: <20030626185659.GR451@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0306262105370.5042-100000@serv>
References: <20030626180909.GP451@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.44.0306262036030.11817-100000@serv>
 <20030626185659.GR451@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 Jun 2003, Matthew Wilcox wrote:

> > config ZLIB_INFLATE
> > 	def_tristate CRAMFS || PPP_DEFLATE || JFFS2_FS || \
> > 		     ZISOFS_FS || CRYPTO_DEFLATE || \
> > 		     (BINFMT_FLAT && BINFMT_ZFLAT)
> 
> Could you document this in Documentation/kbuild/kconfig-language.txt
> please?

Expressions are documented and 'def_tristate ...' is short for 'tristate' 
and 'default ...'

> Does dep_tristate give me that?  Particularly the one with a (*) by it.

Yes.

bye, Roman

