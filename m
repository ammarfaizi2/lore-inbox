Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268837AbRIML2t>; Thu, 13 Sep 2001 07:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268940AbRIML2k>; Thu, 13 Sep 2001 07:28:40 -0400
Received: from falka.mfa.kfki.hu ([148.6.72.6]:49322 "EHLO falka.mfa.kfki.hu")
	by vger.kernel.org with ESMTP id <S268837AbRIML2b>;
	Thu, 13 Sep 2001 07:28:31 -0400
Date: Thu, 13 Sep 2001 13:27:12 +0200 (CEST)
From: Gergely Tamas <dice@mfa.kfki.hu>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
cc: <linux-kernel@vger.kernel.org>, <heinz@auto.tuwien.ac.at>,
        <drebes@inf.ufrgs.br>, <leo@debian.org>
Subject: Re: Stomping on Athlon bug
In-Reply-To: <Pine.LNX.4.33.0109131159390.27066-100000@falka.mfa.kfki.hu>
Message-ID: <Pine.LNX.4.33.0109131325340.31004-100000@falka.mfa.kfki.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > I've got here an ABIT KT7 (duron, 750MHz) with BIOS 3C

Sorry, I've ment ABIT KT7A (with VIA KT133A) of course.

 >
 >  > YH 00: 06 11 05 03 06 00 10 22 03 00 00 06 00 00 00 00
 >    3C 00: 06 11 05 03 06 00 10 22 03 00 00 06 00 00 00 00
 >  > 3R 00: 06 11 05 03 06 00 10 22 03 00 00 06 00 08 00 00
 >  >                                               ^^
 >
 >  > YH 10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
 >    3C 10: 08 00 00 d8 00 00 00 00 00 00 00 00 00 00 00 00
 >  > 3R 10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
 >  >        ^^^^^^^^^^^
 >
 >  > YH 50: 16 f4 eb
 >    3C 50: 16 f4 eb
 >  > 3R 50: 16 f4 6b
 >  >              ^^
 >
 >  > YH 50: .. .. .. b4 06
 >    3C 50: .. .. .. b4 06
 >  > 3R 50: .. .. .. b4 47
 >  >                    ^^
 >
 >  > YH 50: .. .. .. .. .. 00 04 04 00 00 01 02 03 04 04 04
 >    3C 50: .. .. .. .. .. 00 08 08 80 00 04 08 08 08 08 08
 >  > 3R 50: .. .. .. .. .. 89 04 04 00 00 01 02 03 04 04 04
 >  >                       ^^
 >
 >  > YH 60: 0f 0a 00 20 e4 e4 d4 c4 50 28 65 0d 08 5f 00 00
 >    3C 60: 03 aa 00 20 64 54 54 c4 50 08 65 0d 08 3f 00 00
 >  > 3R 60: 0f 0a 00 20 e4 e4 d4 00 50 08 65 0d 08 5f 00 00
 >  >                                   ^^
 >
 >  > YH 70: d4 88 cc 0c 0e 81 d2 00 01 b4 19 02 00 00 00 00
 >    3C 70: d0 88 cc 0c 0e 81 d2 00 01 b4 19 02 00 00 00 00
 >  > 3R 70: d8 88 cc 0c 0e 81 d2 00 01 b4 19 02 00 00 00 00
 >  >        ^^
 >
 >  > YH a0: 02 c0 20 00 03 02 00 1f 00 00 00 00 2b 12 00 00
 >    3C a0: 02 c0 20 00 03 02 00 1f 00 00 00 00 2b 12 00 00
 >  > 3R a0: 02 c0 20 00 03 02 00 1f 00 00 00 00 2f 12 00 00
 >  >                                            ^^
 >
 >  > YH b0: db 63 02
 >    3C b0: db da 02
 >  > 3R b0: db 63 1a
 >  >              ^^
 >
 >  > YH b0: .. .. .. 50 31 ff 80 0a 67 00 00 00 00 00 00 00
 >    3C b0: .. .. .. 48 31 ff 80 0e 67 00 00 00 00 00 00 00
 >  > 3R b0: .. .. .. 50 31 ff 80 0b 67 00 00 00 00 00 00 00
 >  >                             ^^
 >
 >  > YH f0: 00 00 00 00 00 03 03 00 22 00 00 00 00 00 00 00
 >    3C f0: 00 00 00 00 00 03 03 00 22 00 00 00 00 00 00 00
 >  > 3R f0: 00 00 00 00 00 03 03 00 22 00 00 00 00 80 00 00
 >  >                                               ^^
 >
 > Gergely

