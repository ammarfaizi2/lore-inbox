Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316607AbSEPJhg>; Thu, 16 May 2002 05:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316619AbSEPJhf>; Thu, 16 May 2002 05:37:35 -0400
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:24094 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S316607AbSEPJhd>; Thu, 16 May 2002 05:37:33 -0400
Date: Thu, 16 May 2002 11:36:46 +0200 (CEST)
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
cc: tytso@mit.edu
Subject: OX16PCI954 - more than 921600/3000000
Message-ID: <Pine.LNX.4.44.0205161123250.2291-100000@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have serial card with Oxford chipset OX16PCI954-TQC60-A1
It's identify as "Titan Electronics VScom 400H 4 port serial adaptor"
vendor_id: 14d2:a003
I can set speed port to 921600 or 3000000 bits/s, but I would like
set speed precisely to:

1843200 bits/s
3684400 bits/s
2681018 bits/s
or
2268554 bits/s

but I can't because we have in include/asm-i386/termbits.h defines:
#define   B921600 0010007
#define  B1000000 0010010
#define  B1152000 0010011
#define  B1500000 0010012
#define  B2000000 0010013
#define  B2500000 0010014
#define  B3000000 0010015
#define  B3500000 0010016
#define  B4000000 0010017

How I can do that? Please help me. :-) Thank You!

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

