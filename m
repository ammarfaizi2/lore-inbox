Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVAYRXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVAYRXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 12:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVAYRUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 12:20:23 -0500
Received: from mail.suse.de ([195.135.220.2]:41193 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262029AbVAYRRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 12:17:03 -0500
Subject: Re: [patch 1/13] Qsort
From: Andreas Gruenbacher <agruen@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, Andi Kleen <ak@muc.de>,
       Nathan Scott <nathans@sgi.com>,
       Mike Waychison <Michael.Waychison@sun.com>,
       Jesper Juhl <juhl-lkml@dif.dk>, Felipe Alfaro Solana <lkml@mac.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Buck Huppmann <buchk@pobox.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Tim Hockin <thockin@hockin.org>
In-Reply-To: <1106672637.11449.24.camel@lade.trondhjem.org>
References: <20050122203326.402087000@blunzn.suse.de>
	 <41F570F3.3020306@sun.com> <20050125065157.GA8297@muc.de>
	 <200501251112.46476.agruen@suse.de> <20050125120023.GA8067@muc.de>
	 <20050125120507.GH19199@suse.de>
	 <1106671920.11449.11.camel@lade.trondhjem.org>
	 <1106672028.9607.33.camel@winden.suse.de>
	 <1106672637.11449.24.camel@lade.trondhjem.org>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1106673415.9607.36.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 25 Jan 2005 18:16:56 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 18:03, Trond Myklebust wrote:
> ty den 25.01.2005 Klokka 17:53 (+0100) skreiv Andreas Gruenbacher:
> > On Tue, 2005-01-25 at 17:52, Trond Myklebust wrote:
> > > So here's an iconoclastic question or two:
> > > 
> > >   Why can't clients sort the list in userland, before they call down to
> > > the kernel?
> > 
> > Tell that to Sun Microsystems.
> 
> Whatever Sun chooses to do or not do changes nothing to the question of
> why our client would want to do a quicksort in the kernel.

Well, it determines what we must accept, both on the server side and the
client side.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

