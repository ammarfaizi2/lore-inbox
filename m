Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbUAJA2h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 19:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUAJA2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 19:28:37 -0500
Received: from AGrenoble-101-1-5-161.w80-11.abo.wanadoo.fr ([80.11.136.161]:52172
	"EHLO awak.dyndns.org") by vger.kernel.org with ESMTP
	id S264540AbUAJA2b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 19:28:31 -0500
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity
	checking
From: Xavier Bestel <xavier.bestel@free.fr>
To: Christoph Hellwig <hch@infradead.org>
Cc: Maciej Zenczykowski <maze@cela.pl>, Jesper Juhl <juhl-lkml@dif.dk>,
       Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040109204150.A28436@infradead.org>
References: <Pine.LNX.4.56.0401090437060.11276@jju_lnx.backbone.dif.dk>
	 <Pine.LNX.4.44.0401092105070.1739-100000@gaia.cela.pl>
	 <20040109204150.A28436@infradead.org>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1073694475.6189.176.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jan 2004 01:27:56 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven 09/01/2004 à 21:41, Christoph Hellwig a écrit :
> On Fri, Jan 09, 2004 at 09:20:53PM +0100, Maciej Zenczykowski wrote:
> > I think this points to an 'issue', if we're going to increase the checks
> > in the ELF-loader (and thus increase the size of the minimal valid ELF
> > file we can load, thus effectively 'bloating' (lol) some programs) we
> > should probably allow some sort of direct binary executable files [i.e.
> > header 'XBIN386\0' followed by Read/Execute binary code to execute by
> 
> Like binfmt_flat? :)

.. or even zflat. Not that I'm proud of it, but it can effectively
manage to produce rather compact executables :)

	Xav

