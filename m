Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316663AbSGNOAu>; Sun, 14 Jul 2002 10:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316677AbSGNOAt>; Sun, 14 Jul 2002 10:00:49 -0400
Received: from p50886DAC.dip.t-dialin.net ([80.136.109.172]:392 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316663AbSGNOAs>; Sun, 14 Jul 2002 10:00:48 -0400
Date: Sun, 14 Jul 2002 08:03:39 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Joerg Schilling <schilling@fokus.gmd.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <200207141317.g6EDHEaK019069@burner.fokus.gmd.de>
Message-ID: <Pine.LNX.4.44.0207140801000.3331-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 14 Jul 2002, Joerg Schilling wrote:
> > Please stop calling ATAPI as SCSI over IDE, it is not. It is Packet
> > Interface over ATA (IDE). Some ATAPI/SCSI devices are functionally
> > equivalent because they support the same command set (i.e. MMC).
> 
> ATAPI _is_ SCSI over IDE with a few "bugs"/deviations:
> 
> [Blah...]

What you describe is still not SCSI. It's the Packet Interface, and it's 
not run over IDE, but over ATA. You need to know the difference between 
hardware style and command layers, providing that you're really a person 
who has ever written a SCSI driver.

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

