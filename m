Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132407AbRDCSYn>; Tue, 3 Apr 2001 14:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132414AbRDCSYd>; Tue, 3 Apr 2001 14:24:33 -0400
Received: from [212.183.11.206] ([212.183.11.206]:3083 "EHLO
	grips_nts2.grips.com") by vger.kernel.org with ESMTP
	id <S132407AbRDCSY0>; Tue, 3 Apr 2001 14:24:26 -0400
Message-ID: <3ACA150E.5AA55ABE@grips.com>
Date: Tue, 03 Apr 2001 20:23:10 +0200
From: jury gerold <gjury@grips.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: de-AT, en
MIME-Version: 1.0
To: Harald Dunkel <harri@synopsys.COM>
CC: Linux-kernel@vger.kernel.org
Subject: Re: ReiserFS? How reliable is it? Is this the future?
In-Reply-To: <3AC9BE5A.DE079EE1@Synopsys.COM>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use reiserfs on
a) P3(450) machine 440BX/ZX Chipset 82371AB PIIX4 IDE UDMA33
b) athlon(1100) VIA KT133 something IDE UDMA33

On both of them i have spurious small file garbage problems
during compiling.

There was no situation with real trouble, no permanent damage,
restarting the job solved the problem all the time.

I could not find a real corrupt file on disk.
It seems to me like the corruption happens in memory only.
(just an impression)
The machine with less memory triggers it more likely.

On 2.4.3-pre6 a file that has not been changed for months
was sometimes not found.

I have no problems on the ext2 partitions.
