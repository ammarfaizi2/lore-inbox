Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbWBGNSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbWBGNSr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 08:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbWBGNSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 08:18:47 -0500
Received: from albireo.ucw.cz ([84.242.65.108]:9604 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S965070AbWBGNSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 08:18:46 -0500
Date: Tue, 7 Feb 2006 14:18:41 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, jim@why.dont.jablowme.net, peter.read@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060207.131110.9155.albireo@ucw.cz>
References: <20060123105634.GA17439@merlin.emma.line.org> <200602021717.08100.luke@dashjr.org> <Pine.LNX.4.61.0602031502000.7991@yvahk01.tjqt.qr> <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner> <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E89B56.nailA792EWNLG@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joerg!

> Well, while I did explain this many times (*), I am still waiting 
> for an explanation why Linux tries to deviate from nearly all other OS.

The explanation has been given several times: the solution used by Linux
solves much more than just CD recorders.

I intentionally say "CD recorders", not "SCSI devices" nor even "CD drives",
because I don't think I can view as a consistent solution anything which
calls the same drive differently depending on whether I want to read or
write a CD.

I repeatedly asked you why do you think we should call the device
differently for different uses and there were no replies.

> *) in case you like are on amnesia: without the mapping in libscg,
> cdrecord could not be used reliably on Linux. And yes, I _do_ care
> about people who run Linux-2.4 or older!

As you were already told, you can do it by splitting the Linux port
to two, one for Linux 2.4 and older, one for the newer kernels. Some
people even offered help with maintaining the Linux parts of the libscg.

Except for the compatibility problems, I haven't heard any argument
why it "could not be used reliably on Linux".

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
P.C.M.C.I.A. stands for `People Can't Memorize Computer Industry Acronyms'
