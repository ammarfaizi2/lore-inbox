Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266318AbSL1Tfe>; Sat, 28 Dec 2002 14:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266316AbSL1Tfe>; Sat, 28 Dec 2002 14:35:34 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:183 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S266310AbSL1Tfb>; Sat, 28 Dec 2002 14:35:31 -0500
Date: Sat, 28 Dec 2002 20:43:47 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <20021228194347.GC17051@louise.pinerecords.com>
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com> <176730000.1040430221@aslan.btc.adaptec.com> <3E03BB0D.5070605@rackable.com> <Pine.LNX.4.50L.0212280331110.30646-100000@freak.distro.conectiva> <20021228091608.GA13814@louise.pinerecords.com> <Pine.LNX.4.50L.0212281131580.26879-100000@imladris.surriel.com> <705128112.1041102818@aslan.scsiguy.com> <Pine.LNX.4.50L.0212281718110.26879-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0212281718110.26879-100000@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [riel@conectiva.com.br]
> 
> On Sat, 28 Dec 2002, Justin T. Gibbs wrote:
> 
> > Unfortunately, the versions of the aic7xxx driver that are in the main
> > trees (both nearly a year out of date) don't have this test and, like the
> > "old" driver, they default to memory mapped I/O.  One of the reasons I've
> > been pushing so hard for this new driver to go into the tree is that 90%
> > of the complaints about the new driver would go away if it were updated
> > to a sane revision.
> 
> Ohhhh, that would certainly explain.  Where could I get a patch
> to update a recent 2.4 kernel to your latest aic7xxx driver ?
> 
> I'll happily test it on the machines where I have access...

http://people.freebsd.org/~gibbs/linux/SRC/aic79xx-linux-2.4-20021220.tar.gz
(Both the 7xxx and 79xx drivers are included.)

-- 
Tomas Szepe <szepe@pinerecords.com>
