Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132535AbRDNUOk>; Sat, 14 Apr 2001 16:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132537AbRDNUOU>; Sat, 14 Apr 2001 16:14:20 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:42266 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S132535AbRDNUOR>; Sat, 14 Apr 2001 16:14:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jeff Lightfoot <jeffml@pobox.com>
Reply-To: jeffml@pobox.com
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon runtime problems
Date: Sat, 14 Apr 2001 14:14:17 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <E14oRie-000556-00@the-village.bc.nu>
In-Reply-To: <E14oRie-000556-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <01041414141700.00938@earth>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ sent to linux-kernel due to Alan rejecting all mail from 
Earthlink/Mindspring, I'm assuming he is still interested in the 
report though ]

On Saturday 14 April 2001 09:13, Alan Cox wrote:
> Can the folks who are seeing crashes running athlon optimised
> kernels all mail me

I have two Athlon machines with mysterious (no oops) lockups.  I've 
just started running them as 586 to see if that stops the lockups.

The first one:
> -	CPU model/stepping
model		: 4
model name	: AMD Athlon(tm) Processor
stepping		: 2
cpu MHz	: 1195.214

> -	Chipset
VIA KT133/KM133
(Iwill KK266)

> -	Amount of RAM
MemTotal:       770960 kB

> -	/proc/mtrr output
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0x20000000 ( 512MB), size= 256MB: write-back, count=1
reg02: base=0xd4000000 (3392MB), size=  32MB: write-combining, count=2
reg05: base=0xd0000000 (3328MB), size=  64MB: write-combining, count=2

> -	compiler used
gcc 2.95.4

The second one:
> -	CPU model/stepping

model		: 4
model name	: AMD Athlon(tm) Processor
stepping		: 2
cpu MHz	: 1000.050

> -	Chipset
VIA KT133/KM133
(MSI K7TPro)

> -	Amount of RAM
MemTotal:       255588 kB

> -	/proc/mtrr output
reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
reg05: base=0xd0000000 (3328MB), size=  64MB: write-combining, count=1

> -	compiler used
gcc 2.95.4

