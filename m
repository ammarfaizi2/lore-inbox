Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315783AbSFCXWE>; Mon, 3 Jun 2002 19:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315784AbSFCXWD>; Mon, 3 Jun 2002 19:22:03 -0400
Received: from pD9E23450.dip.t-dialin.net ([217.226.52.80]:29067 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315783AbSFCXWC>; Mon, 3 Jun 2002 19:22:02 -0400
Date: Mon, 3 Jun 2002 17:22:01 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Dominik Geisel <devnull@geisel.info>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.19 fails to compile on GCC 3.1.1
In-Reply-To: <Pine.LNX.4.44.0206032223140.12337-100000@pc1.geisel.info>
Message-ID: <Pine.LNX.4.44.0206031719030.3833-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 3 Jun 2002, Dominik Geisel wrote:
> ----------------------------------------------------------
> drivers/built-in.o: In function `ata_module_init':
> drivers/built-in.o(.text.init+0x6530): undefined reference to `idescsi_init'
> ----------------------------------------------------------

Strange enough, in my whole tree idescsi_init is only declared, but never 
used. Not even at ata_module_init...

> # ATA and ATAPI Block devices

Could you please ungrep the comments (the lines containing the bash (#) 
character) the next time? Thanks.

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

