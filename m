Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbUCHFhs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 00:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbUCHFhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 00:37:48 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:44808 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S262392AbUCHFhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 00:37:11 -0500
Date: Mon, 8 Mar 2004 02:22:36 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: Adrian Bunk <bunk@fs.tum.de>
cc: Daniel Egger <degger@fhm.edu>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       <jgarzik@pobox.com>, <linux-net@vger.kernel.org>
Subject: Re: [2.4 patch] MAINTAINERS: remove LAN media entry
In-Reply-To: <20040307155008.GM22479@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0403080221520.2604-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Mar 2004, Adrian Bunk wrote:

> On Sat, Feb 28, 2004 at 11:57:11AM +0100, Daniel Egger wrote:
> > On Feb 27, 2004, at 9:54 pm, Adrian Bunk wrote:
> > 
> > >IOW:
> > >The entry from MAINTAINER can be removed?
> > 
> > This one for sure. The same is probably sensible for the
> > drivers, too. It's just too confusing to not several
> > versions of the driver floating around which need different
> > tools. And since the manufacturer propagates their own
> > version, the linux one should go...
> >...
> 
> 
> It's a question whether removing drivers from a stable kernel series is 
> a good idea, but the following is definitely correct:
> 
> 
> --- linux-2.4.26-pre2-full/MAINTAINERS.old	2004-03-07 16:48:59.000000000 +0100
> +++ linux-2.4.26-pre2-full/MAINTAINERS	2004-03-07 16:49:09.000000000 +0100
> @@ -1077,12 +1077,6 @@
>  W:	http://www.cse.unsw.edu.au/~neilb/oss/knfsd/
>  S:	Maintained
>  
> -LANMEDIA WAN CARD DRIVER
> -P:      Andrew Stanley-Jones
> -M:      asj@lanmedia.com
> -W:      http://www.lanmedia.com/
> -S:      Supported
> - 
>  LAPB module
>  P:	Henner Eisen
>  M:	eis@baty.hanse.de
> 

I think it might be better to change to


LANMEDIA WAN CARD DRIVER
S: UNMAINTAINED

Thoughts? 



