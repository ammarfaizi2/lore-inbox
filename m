Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUFQLqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUFQLqN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 07:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266459AbUFQLqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 07:46:13 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:24497 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264561AbUFQLqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 07:46:11 -0400
Date: Thu, 17 Jun 2004 13:45:33 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: make checkstack on m68k
Message-ID: <20040617114533.GA12062@wohnheim.fh-wedel.de>
References: <Pine.GSO.4.58.0406161845490.1249@waterleaf.sonytel.be> <20040616180402.GB15365@wohnheim.fh-wedel.de> <Pine.GSO.4.58.0406171024271.21503@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.GSO.4.58.0406171024271.21503@waterleaf.sonytel.be>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 June 2004 10:25:24 +0200, Geert Uytterhoeven wrote:
> > > -	$(PERL) scripts/checkstack.pl $(ARCH)
> > > +	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)
> >
> > Does this actually matter?  Didn't hurt me yet.
> 
> Do you ever use `make -C path_to_src_tree O=$(pwd) checkstack'?

Ok, convinced.

Jörn

-- 
Eighty percent of success is showing up.
-- Woody Allen
