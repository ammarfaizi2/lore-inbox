Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317766AbSFLTLj>; Wed, 12 Jun 2002 15:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317767AbSFLTLi>; Wed, 12 Jun 2002 15:11:38 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:17927 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S317766AbSFLTLh>; Wed, 12 Jun 2002 15:11:37 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15623.40169.289632.64185@laputa.namesys.com>
Date: Wed, 12 Jun 2002 23:11:37 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Pavel Machek <pavel@ucw.cz>
Cc: Dawson Engler <engler@csl.Stanford.EDU>, linux-kernel@vger.kernel.org,
        mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
In-Reply-To: <20020612084349.GA986@elf.ucw.cz>
X-Mailer: VM 7.04 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
 > Hi!
 > 
 > > # BUGs	|	File Name
 > > 4	|	/drivers/cdrom.c
 > > 4	|	/message/i2o_proc.c
 > > 3	|	/net/airo.c
 > > 3	|	/../inflate.c
 > > 2	|	/fs/zlib.c
 > > 2	|	/drivers/zlib.c
 > > 2	|	/drivers/cpqfcTScontrol.c
 > 		~~~~~~~~~~~~~~~~~~~~~~~~~

By the way, gcc has -Wlarger-than-NNNN option to do such checks.

 > 
 > Actually, 3 bugs, the name is so ugly that it is a bug, too :-).
 > 									Pavel

Nikita.
