Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279949AbRKRSCT>; Sun, 18 Nov 2001 13:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279934AbRKRSCJ>; Sun, 18 Nov 2001 13:02:09 -0500
Received: from cpe.atm0-0-0-122182.0x3ef30264.bynxx2.customer.tele.dk ([62.243.2.100]:17782
	"HELO fugmann.dhs.org") by vger.kernel.org with SMTP
	id <S279969AbRKRSB4>; Sun, 18 Nov 2001 13:01:56 -0500
Message-ID: <3BF7F792.8010403@fugmann.dhs.org>
Date: Sun, 18 Nov 2001 19:01:54 +0100
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: John Jasen <jjasen@realityfailure.org>, linux-kernel@vger.kernel.org
Subject: Re: SiS630 chipsets && linux 2.4.x kernel == snails pace?
In-Reply-To: <Pine.LNX.4.33.0111180957020.10229-100000@geisha.realityfailure.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

One thing i cannot see is "unmaskirq" setting.
So I would really like to see the output of a plain
hdparm /dev/hda.

As far as I can see the 2.4.X kernel gives much better throughput,
but 4-5 hours for compiling the kernel is way too long on a 700Mhz 
celeron. Please try to do a
$ make dep clean && time make bzImage -j 3
on both 2.2.19 and 2.4.X kernel and send the time information.

The line
"PCI: No IRQ known for interrupt pin A of device 00:00.1. Please try 
using pci=biosirq." in the dmesg output is strange. Have you tried to do 
what is says?
I've only seen it on my server, where I have disabled my onboard 
controller, which means that the BIOS does not allocate an interrupt pin 
for it. Have you looked in the BIOS, to see if the controller is enabled 
correctly?

Regards
Anders Fugmann

