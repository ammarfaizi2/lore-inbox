Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266849AbUHSRa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266849AbUHSRa3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 13:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266851AbUHSRa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 13:30:28 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:30085 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S266849AbUHSRaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 13:30:24 -0400
Date: Thu, 19 Aug 2004 19:30:25 +0200
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       kernel@wildsau.enemy.org, diablod3@gmail.com
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040819173025.GA15220@ucw.cz>
References: <200408041233.i74CX93f009939@wildsau.enemy.org> <d577e5690408190004368536e9@mail.gmail.com> <4124A024.nail7X62HZNBB@burner> <20040819131026.GA9813@ucw.cz> <4124AD46.nail80H216HKB@burner> <20040819135614.GA12634@ucw.cz> <4124B314.nail8221CVOE9@burner> <20040819141442.GC13003@ucw.cz> <20040819150704.GB1659@merlin.emma.line.org> <4124C46B.nail83H31GJ2S@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4124C46B.nail83H31GJ2S@burner>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >$ /opt/schily/bin/cdrecord -version
> >Cdrecord-Clone 2.01a37 (i686-pc-linux-gnu) Copyright (C) 1995-2004 J???rg Schilling
> >/opt/schily/bin/cdrecord: Warning: Running on Linux-2.6.8.1
> >/opt/schily/bin/cdrecord: There are unsettled issues with Linux-2.5 and newer.
> 									^^^^^^
> 									should 
> 									be "later"

Heh, this is your own bug ;-)  This exact message is in cdrecord/cdrecord.c
in your cdrtools-2.01a38-pre.tar.bz2.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Current root password is "p3s5vwF50". Keep secret.
