Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271589AbRIGHdd>; Fri, 7 Sep 2001 03:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271598AbRIGHdY>; Fri, 7 Sep 2001 03:33:24 -0400
Received: from ns1.yifansoft.com ([64.61.26.50]:39699 "HELO mail.yifansoft.com")
	by vger.kernel.org with SMTP id <S271589AbRIGHdO>;
	Fri, 7 Sep 2001 03:33:14 -0400
Reply-To: <blackfoot@yifan.net>
From: "Jim Blomo" <blackfoot@yifan.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon doesn't like Athlon optimisation?
Date: Fri, 7 Sep 2001 00:33:55 -0700
Message-ID: <PAEKIKPEKOCEFPAENNPCOELICBAA.blackfoot@yifan.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am having a similar problem with my new board/chip. I am using
2.4.10-pre4, and when I compile with the Athlon/Thunderbird setting, the
kernel does absolutely nothing after being uncompressed by LILO. The
computer locks up and I must do a hard reboot to get going again. I have had
no errors (for about 1.5 days) when using the same kernel compiled as 386
and Pentium pro without any other changes. When I used make bzdisk and tried
to boot from that, it repeated the following message over and over until I
did a soft reset:

1007
AX:020C
BX:0000
CX:0007
DX:0000

When booting with the same disk with Athlon not selected as the chip, I had
no errors. Windows 200 has been running with no visible errors for several
days on the same hardware. Memory checks have turned up no errors with my
hardware. Here's some more specific info:

Motherboard + chipset:
 ECS K7AMA + Ali Magic 1645 & Magic 1535D
(http://www.ecs.com.tw/products/k7ama.htm)
FSB Speed:
 266
CPU + multiplier:
 Athlon Thunderbird 1.33Ghz not overclocked
cat /proc/cpuinfo:
 processor	: 0
 vendor_id	: AuthenticAMD
 cpu family	: 6
 model		: 4
 model name	: AMD Athlon(tm) Processor
 stepping	: 4
 cpu MHz		: 1333.382
 cache size	: 256 KB
 fdiv_bug	: no
 hlt_bug		: no
 f00f_bug	: no
 coma_bug	: no
 fpu		: yes
 fpu_exception	: yes
 cpuid level	: 1
 wp		: yes
 flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36
mmx fxsr syscall mmxext 3dnowext 3dnow
 bogomips	: 2660.76
RAM type + speed:
 2 stick of 256MB DDR PC2100 (DDR CAS Select: 2.5/3)
Wattage:
 300 watt power supply

I've seen postings on this subject on the web archives, so is it general
opinion that this is a known issue with Athlons? Should I try to return the
chip? I would be happy with a work around, so what other CPU option gives
the best performance?

I hope I have provided enough information (this is my first post to this
list). Please CC me any replies as I am not subscribed to the list. Thanks
for any information!

Jim

