Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315285AbSGNN4W>; Sun, 14 Jul 2002 09:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315287AbSGNN4V>; Sun, 14 Jul 2002 09:56:21 -0400
Received: from p50886DAC.dip.t-dialin.net ([80.136.109.172]:61575 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315285AbSGNN4V>; Sun, 14 Jul 2002 09:56:21 -0400
Date: Sun, 14 Jul 2002 07:59:11 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Joerg Schilling <schilling@fokus.gmd.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <200207141308.g6ED86GK019067@burner.fokus.gmd.de>
Message-ID: <Pine.LNX.4.44.0207140756450.3331-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 14 Jul 2002, Joerg Schilling wrote:
> This is my idea too: CD-ROM drives should be accessed via ATAPI or 
> handled as ATA disk.

Handling them as an ATA disk will eat you up at some extent - whilst you 
can't change an ATA disk on runtime (well, not easily, at least), you must 
be able to change the CD in your non-ATAPI CD-ROM. If we handle it as an 
ATA disk, we'll lead into trouble. Non-ATAPI CD-ROMs aren't ATA hard 
disks.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

