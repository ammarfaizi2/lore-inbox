Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267951AbRGZNdz>; Thu, 26 Jul 2001 09:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267961AbRGZNdq>; Thu, 26 Jul 2001 09:33:46 -0400
Received: from charybda.fi.muni.cz ([147.251.48.214]:12038 "HELO
	charybda.fi.muni.cz") by vger.kernel.org with SMTP
	id <S267951AbRGZNda>; Thu, 26 Jul 2001 09:33:30 -0400
From: Jan Kasprzak <kas@informatics.muni.cz>
Date: Thu, 26 Jul 2001 15:33:34 +0200
To: craig.schlenter@freemail.absa.co.za
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Linux 2.4 networking/routing slowdown]
Message-ID: <20010726153334.M1024@informatics.muni.cz>
In-Reply-To: <3B600EAD.3F8F9A70@isg.de> <3B6010EC.B7428A0D@isg.de> <20010726145442.K1024@informatics.muni.cz> <20010726152322.A1339@codefountain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010726152322.A1339@codefountain.com>; from craig.schlenter@freemail.absa.co.za on Thu, Jul 26, 2001 at 03:23:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

[Cc'd linux-kernel as well, maybe this can help someone]

craig.schlenter@freemail.absa.co.za wrote:
: Are you sure the network cards are running at full speed - perhaps
: something has decided to run at half duplex or whatever due to a network
: driver change ... how about putting the box on the network without
: having it do any routing and just doing a couple of ftp's to other local
: machines to check the speeds with 2.2 and 2.4 kernels, testing all the cards
: involved ...

	The NICs on firewall are set up to 100baseTX-FD using /sbin/mii-tool
(and in 2.2. kernel, they are hardcoded to 100baseTX-FD via the boot
parameters).

	The FTP from firewall to our FTP server (which is connected to the
same switch - Cisco Catalyst 2900) is slow as well (I tried to
get /pub/FILES.byname /dev/null).

-Y.

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
--Just returned after being 10 days off-line. Sorry for the delayed reply.--
