Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269821AbUH0Aa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269821AbUH0Aa0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269823AbUH0AaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:30:15 -0400
Received: from smtp04.ya.com ([62.151.11.162]:62879 "EHLO smtpauth.ya.com")
	by vger.kernel.org with ESMTP id S269821AbUH0AUM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:20:12 -0400
From: David =?iso-8859-15?q?Mart=EDnez_Moreno?= <ender@debian.org>
Organization: Debian
To: "Pankaj Agarwal" <pankaj@pnpexports.com>
Subject: Re: Help Root Raid
Date: Fri, 27 Aug 2004 02:19:55 +0200
User-Agent: KMail/1.6.2
Cc: <linux-kernel@vger.kernel.org>, ender@debian.org
References: <002301c485cc$3777fed0$9159023d@dreammachine> <200408260130.39772.ender@debian.org> <000e01c48b2c$29c69ac0$2559023d@dreammachine>
In-Reply-To: <000e01c48b2c$29c69ac0$2559023d@dreammachine>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408270220.01499.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El Jueves, 26 de Agosto de 2004 07:17, Pankaj Agarwal escribió:
> Hi Ender,
>
> Thanks for looking into it and for your help. I am hereby enclosing the
> output of dmesg along with this mail. hdc(samsung ide) is the one i want to
> retrieve data from.

 Ooohhhhh...I think that I know what is your problem:

Linux version 2.2.14-12smp (root@porky.devel.redhat.com) (gcc version 
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 SMP Tue Apr 25 12:58:06 
EDT 2000

 Back in 2.2.x times, RAID was not autodetected (if I recall correctly). So 
your old Linux is unable to start the RAID.

 Get a miniKnoppix or some other simple modern rescue system (any 
RH/SuSE/Debian/... installation CD will do the trick), and boot with it. It 
would be the nicest way of recovering your data.

 Regards,


  Ender.
- -- 
Network engineer
Debian Developer
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBLn4xWs/EhA1iABsRAt0PAKCfnnCyxHF8DnuFnJWU44lIWbGTmACeJXS3
wzZB2QjR/zOwPFQUHpxMfIQ=
=QSoc
-----END PGP SIGNATURE-----
