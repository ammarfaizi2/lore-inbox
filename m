Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132877AbRDPISW>; Mon, 16 Apr 2001 04:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132876AbRDPISM>; Mon, 16 Apr 2001 04:18:12 -0400
Received: from wv-morgantown1-213.mgtnwv.adelphia.net ([24.50.80.213]:20989
	"HELO hestia.localdomain") by vger.kernel.org with SMTP
	id <S132875AbRDPIR5>; Mon, 16 Apr 2001 04:17:57 -0400
Date: Mon, 16 Apr 2001 04:17:56 -0400
From: David Smith <davidsmith@acm.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon runtime problems
Message-ID: <20010416041756.A813@akira>
Mail-Followup-To: David Smith <davidsmith@acm.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can the folks who are seeing crashes running athlon optimised kernels all
> mail me
> - CPU model/stepping
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 902.064

thunderbird 900 (200 MHz FSB)

> - Chipset
IWill KK266R, VIA KT133A north, 686B south bridges. IDE RAID is disabled.

> - Amount of RAM
256 M generic pc100.

> - /proc/mtrr output
(while in X, with geforce2 card, and AGP aperature set to 128)
reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
reg01: base=0xd8000000 (3456MB), size=  32MB: write-combining, count=1
reg05: base=0xd0000000 (3328MB), size= 128MB: write-combining, count=1

> - compiler used
gcc version 2.95.4 20010319 (Debian prerelease)
debian gcc package version 1:2.95.3-7


Is there any other information I can provide?

I also seem to have a problem running 2.4.3 (official and ac1-6) kernels
without K7 optimizations, it locks up under I/O using several interrupts (no
IDE involved). I'll post a message about it when I can keep it up long enough
to get debugging information.
