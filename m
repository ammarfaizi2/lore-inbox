Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313920AbSDPVpA>; Tue, 16 Apr 2002 17:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313922AbSDPVo7>; Tue, 16 Apr 2002 17:44:59 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:18898 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S313920AbSDPVo6>; Tue, 16 Apr 2002 17:44:58 -0400
Message-ID: <3CBCB762.4030902@bingo-ev.de>
Date: Tue, 16 Apr 2002 23:44:34 +0000
From: Michael Obster <michael.obster@bingo-ev.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020328
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: AMD Athlon + VIA Crashing On Disk I/O
In-Reply-To: <Pine.LNX.4.33.0204160921060.472-100000@polywog.navpoint.com> <00dc01c1e58b$668dd2f0$0201a8c0@homer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

>>I get (when FSCK):
>>
>>spurious 8259A IRQ7

I also get this message every time i boot my machine when the fs are 
mounted. but i don't had a machine lock yet.
Configuration: Athlon 1GHz on a VIA chip (ASUS A7V).
Btw. What does this message say?

> First check out what kind of chipset you really have;
> lspci -xs 0:0
> should do the thing. Post the results.

Kernel is 2.4.19pre5

my result is:
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] 
(rev 02)
00: 06 11 05 03 06 00 10 22 02 00 00 06 00 08 00 00
10: 08 00 00 e4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 33 80
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

I hope you can do s.th. with that.

Regards,
Michael

------------------------------------------------------
do you want to rock?
http://www.rocklinux.org/
------------------------------------------------------

