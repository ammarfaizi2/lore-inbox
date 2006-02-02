Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423444AbWBBKVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423444AbWBBKVH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423445AbWBBKVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:21:07 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3817 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1423444AbWBBKVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:21:06 -0500
Date: Thu, 2 Feb 2006 11:21:05 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jengelh@linux01.gwdg.de, bzolnier@gmail.com, mrmacman_g4@mac.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       James@superbug.co.uk, j@bitron.ch, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060202.100946.25899.atrey@ucw.cz>
References: <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner> <1138642683.7404.31.camel@juerg-pd.bitron.ch> <43DF3C3A.nail2RF112LAB@burner> <58cb370e0601310410r46210e8dvc66f631f208e9b8d@mail.gmail.com> <43DF678E.nail3B431CUWJ@burner> <58cb370e0601310623ic220d27q3bfd4642cd0538fb@mail.gmail.com> <Pine.LNX.4.61.0602011630440.22529@yvahk01.tjqt.qr> <43E1D5AD.nail4MI2R8NR2@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E1D5AD.nail4MI2R8NR2@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Why not using fully dynamical loadable kernel modules as done with Solaris 
> since 1992? Since that time nobody cares because what you need is auto-loaded 
> on demand and there is absolutely no need for a manual configuration.

Yes, but it still eats the memory if loaded.

> BTW: Introducing an orthogonal SCSI based implementation would save a lot of
> code. The model currently used on Linux is duplicating a lot of unneeded code 
> in target drivers and the SCSI glue code is only a few KB (less than 30k on 
> Solaris). 

Please stop beating a dead horse and diverting this discussion to irrelevant
implementation details.

What we were (and should be) discussing are the interfaces. If you have
any sound arguments against the current interface, speak up.

Whether the interface leads to code duplication is neither yours nor
mine to judge -- the only people who should care are the maintainers
of the drivers and they seem to be happy with the current approach
and they are willing to improve it to simplify scanning.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"Beware of bugs in the above code; I have only proved it correct, not tried it." -- D.E.K.
