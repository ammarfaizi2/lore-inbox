Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266853AbRG1QAc>; Sat, 28 Jul 2001 12:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266864AbRG1QAW>; Sat, 28 Jul 2001 12:00:22 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:5133 "HELO postfix2-1.free.fr")
	by vger.kernel.org with SMTP id <S266853AbRG1QAT>;
	Sat, 28 Jul 2001 12:00:19 -0400
Message-ID: <3B6335EB.14F9866D@free.fr>
Date: Sat, 28 Jul 2001 18:00:11 -0400
From: PEIFFER Pierre <ppeiffer@free.fr>
X-Mailer: Mozilla 4.77 [fr] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kurt Garloff <garloff@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA KT133A / athlon / MMX
In-Reply-To: <E15QE4v-0006R5-00@the-village.bc.nu> <20010728083724.A1571@weta.f00f.org> <3B62F660.FAAB2071@free.fr> <20010728142157.A6487@pckurt.casa-etp.nl>
Content-Type: multipart/mixed;
 boundary="------------746F161984FC8DB79DCFF74C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Il s'agit d'un message multivolet au format MIME.
--------------746F161984FC8DB79DCFF74C
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Kurt Garloff a écrit :
> 
> A lspci -vxxx of your northbridge with adn without the BIOS option will
> reveal more.

In attached files are the result. I've only kept the (what I suppose to
be) northbridge info.
This doesn't tell me anything...

Note: both has been done after booting on  Mandrake-kernel 2.4.3 which
come with Mandrake distribution (i.e. with lot of patches and
options...) I don't know the impact on the result...

Pierre
--------------746F161984FC8DB79DCFF74C
Content-Type: text/plain; charset=us-ascii;
 name="lspci_opt_disable.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci_opt_disable.txt"

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
	Subsystem: ABIT Computer Corp.: Unknown device a401
	Flags: bus master, medium devsel, latency 0
	Memory at d8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2
00: 06 11 05 03 06 00 10 a2 03 00 00 06 00 00 00 00
10: 08 00 00 d8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 7b 14 01 a4
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 17 a3 eb b4 02 00 10 10 c0 00 08 10 10 10 10 10
60: 03 aa 02 20 e6 d6 d6 c6 51 28 43 0d 08 3f 00 00
70: d4 88 cc 0c 0e 81 62 00 01 b4 19 02 00 00 00 00
80: 0f 40 00 00 c0 00 00 00 02 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 32 00 00
a0: 02 c0 20 00 17 02 00 1f 00 00 00 00 2b 12 14 00
b0: 49 da 00 60 31 ff 80 05 67 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 03 03 00 22 00 00 00 00 00 00 00


--------------746F161984FC8DB79DCFF74C
Content-Type: text/plain; charset=us-ascii;
 name="lspci_opt_enable.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci_opt_enable.txt"

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
	Subsystem: ABIT Computer Corp.: Unknown device a401
	Flags: bus master, medium devsel, latency 8
	Memory at d8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2
00: 06 11 05 03 06 00 10 a2 03 00 00 06 00 08 00 00
10: 08 00 00 d8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 7b 14 01 a4
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 17 a3 eb b4 43 89 10 10 c0 00 08 10 10 10 10 10
60: 03 aa 02 20 e6 d6 d6 c6 45 28 43 0f 08 3f 00 00
70: d4 88 cc 0c 0e 81 62 00 01 b4 19 02 00 00 00 00
80: 0f 40 00 00 c0 00 00 00 02 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 32 00 00
a0: 02 c0 20 00 17 02 00 1f 00 00 00 00 2f 12 14 00
b0: 49 da 88 60 31 ff 80 05 67 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 03 03 00 22 00 00 00 00 00 91 06


--------------746F161984FC8DB79DCFF74C--

