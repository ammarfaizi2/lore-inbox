Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262656AbVBYJ0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbVBYJ0q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 04:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVBYJ0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 04:26:46 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:40106 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262656AbVBYJ0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 04:26:44 -0500
Date: Fri, 25 Feb 2005 02:26:40 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport do_settimeofday
Message-ID: <20050225092640.GS27352@schnapps.adilger.int>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>, bunk@stusta.de,
	linux-kernel@vger.kernel.org
References: <20050224233742.GR8651@stusta.de> <20050224212448.367af4be.akpm@osdl.org> <1109318525.6290.32.camel@laptopd505.fenrus.org> <20050225002804.4905b649.akpm@osdl.org> <58cb370e050225004759e1dc59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e050225004759e1dc59@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 25, 2005  09:47 +0100, Bartlomiej Zolnierkiewicz wrote:
> On Fri, 25 Feb 2005 00:28:04 -0800, Andrew Morton <akpm@osdl.org> wrote:
> > Adrian Bunk <bunk@stusta.de> wrote:
> > >  I haven't found any possible modular usage of do_settimeofday in the
> > >  kernel.
> > 
> > Sure.  But there must have been a reason to export it in the first place.
> 
> sloppy coding?

Who knows?  Maybe someone developed a kernel module that interfaces to an
unusual clock chip on their motherboard.  IMHO, all of this "_I_ don't
see any use for it, lets get rid of it because it's not useful" changing
is just a source of grief for anyone that doesn't have their code in
the kernel.

Cheers, Andreas
--
Andreas Dilger

