Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316933AbSGNQyO>; Sun, 14 Jul 2002 12:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316935AbSGNQyN>; Sun, 14 Jul 2002 12:54:13 -0400
Received: from p50886DAC.dip.t-dialin.net ([80.136.109.172]:10633 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316933AbSGNQyM>; Sun, 14 Jul 2002 12:54:12 -0400
Date: Sun, 14 Jul 2002 10:56:54 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Paul Bristow <paul@paulbristow.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <3D3184EF.8040109@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0207141054480.3331-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> My concern is only the fact that it would be easier in my opinnion to
> start off with ide-scsi and make it *independant* from the SCSI code or
> device handling by separating commonly used code for MMC_ handling out
> of SCSI in a kind of library (that is it) and not a common "layer" (this
> could be a second step).

What about some kind of

retval_t mmc_to_hostcmd(host, cmd, ...);
response_t response_to_mmc(host, ...);

?

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

