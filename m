Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293549AbSBZJJl>; Tue, 26 Feb 2002 04:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293550AbSBZJJb>; Tue, 26 Feb 2002 04:09:31 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:5638 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S293549AbSBZJJM>; Tue, 26 Feb 2002 04:09:12 -0500
Date: Tue, 26 Feb 2002 10:09:06 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18
Message-ID: <20020226090906.GA9245@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020225233230.GB11786@merlin.emma.line.org> <Pine.LNX.3.96.1020226000221.20055B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020226000221.20055B-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Bill Davidsen wrote:

> On Tue, 26 Feb 2002, Matthias Andree wrote:
> 
> > I'd think that running a script to "upgrade" 2.4.N-rcM to 2.4.N by just
> > unpacking that latest rc tarball, editing the Makefile and tarring
> > things up again, should be safe enough, and if it doesn't allow for
> > operator interference, especially so. 
> 
> Seems to me:
> - clean EXTRAVERSION
> - make new diff

Correct, I forgot about this item -- but it's a longer distance, from
2.4.N-1 to 2.4.N. Thank you.

> - make tar (one please)
> - make tar.gz from tar
> - compress tar to tar.bz2
