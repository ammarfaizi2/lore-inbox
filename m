Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266991AbTAWXdW>; Thu, 23 Jan 2003 18:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267267AbTAWXdW>; Thu, 23 Jan 2003 18:33:22 -0500
Received: from relay03.roc.frontiernet.net ([66.133.131.36]:45185 "EHLO
	relay03.roc.frontiernet.net") by vger.kernel.org with ESMTP
	id <S266991AbTAWXdW>; Thu, 23 Jan 2003 18:33:22 -0500
Date: Thu, 23 Jan 2003 18:42:29 -0500
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Aic7xxx 6.2.28 and Aic79xx 1.3.0 Released
Message-ID: <20030123184229.C7016@newbox.localdomain>
References: <87730000.1043275833@aslan.btc.adaptec.com> <200301231215.h0NCEws23149@Port.imtp.ilyichevsk.odessa.ua> <331830000.1043334482@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <331830000.1043334482@aslan.scsiguy.com>; from gibbs@scsiguy.com on Thu, Jan 23, 2003 at 08:08:02AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin T. Gibbs on Thu 23/01 08:08 -0700:
> > I didn't track your development efforts too closely...  does this
> > mean that latest 2.4 (2.4.20?) will detect my oldie 7782?
> 
> The Olvetti EISA IDs have been included since 6.2.24?? or so.

Which means that they won't be detected with the 2.4 mainline tree,
which appears to have 6.2.8 in 21-pre3.

FWIW, I can't run my NFS server without Justin's patches; it blows up
easily under load (even a simple resync of the RAID array running off it
causes all kinds of errors after only a few minutes).  This is a 7892.

With Justin's 6.2.24 driver it works great even when I beat the hell out
of it.
