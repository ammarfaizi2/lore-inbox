Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289577AbSAJRrI>; Thu, 10 Jan 2002 12:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289580AbSAJRqz>; Thu, 10 Jan 2002 12:46:55 -0500
Received: from dsl-213-023-062-090.arcor-ip.net ([213.23.62.90]:56591 "HELO
	spot.local") by vger.kernel.org with SMTP id <S289574AbSAJRpj>;
	Thu, 10 Jan 2002 12:45:39 -0500
Date: Thu, 10 Jan 2002 18:48:22 +0100
From: Oliver Feiler <kiza@gmxpro.net>
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org
Subject: Re: HPT370 controller set wrong udma mode
Message-ID: <20020110184822.A246@gmxpro.net>
In-Reply-To: <20020110160718.A296@gmxpro.net> <E16OhTs-0004iz-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16OhTs-0004iz-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 10, 2002 at 03:51:04PM +0000
X-Operating-System: Linux 2.4.16 i686
X-Species: Snow Leopard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Make sure you use the Andre Hedrick ide patches with the HPT 370. That fixed
> all my problems with them at least
> 	(http://www.linux-ide.org)

	Didn't solve my problem unfortunately.

	With the patch applied, the kernel still says it uses UDMA(66) on boot 
and hdparm also says the drive is in udma4 mode. Writing data to it results in 
BadCRC.
	However, /proc/ide/hpt366 with the patch applied shows ATA-33 mode. 
Something's wrong here.

	CC'ing this to Andre Hedrick. Maybe he knows what's wrong?

Bye

Oliver

-- 
Oliver Feiler                                               kiza@gmx.net
http://www.lionking.org/~kiza/pgpkey              PGP key ID: 0x561D4FD2
http://www.lionking.org/~kiza/
