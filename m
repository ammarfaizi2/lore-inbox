Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129417AbRCABh4>; Wed, 28 Feb 2001 20:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129438AbRCABhn>; Wed, 28 Feb 2001 20:37:43 -0500
Received: from zeus.kernel.org ([209.10.41.242]:51676 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129464AbRCAB2Z>;
	Wed, 28 Feb 2001 20:28:25 -0500
Message-ID: <3A9D931A.E0FA6C81@mandrakesoft.com>
Date: Wed, 28 Feb 2001 19:08:58 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root <root@marge.springfield.attws.com>
Cc: tulip-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: patch for mini-pci ethernet card
In-Reply-To: <01021519112800.09592@marge.springfield>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root wrote:
> I have a HP Pavilon 5290 laptop. It has a a mini-pci modem/ethernet combo
> integrated card.
> 
> Searching in the Internet I found a patch for the ethernet to work with the
> tulip driver for kernel 2.2.x series, However, I found no patch for the 2.4.x
> kernel series, so I made one.
> 
> Here is what /proc/pci detects as the ethernet card.
> 
>   Bus  0, device  16, function  0:
>     Ethernet controller: PCI device 1113:1216 (Accton Technology Corporation)
> (rev 17).
>       IRQ 11.
>       Master Capable.  Latency=64.  Min Gnt=255.Max Lat=255.
>       I/O at 0x1c00 [0x1cff].
>       Non-prefetchable 32 bit memory at 0xe8000000 [0xe80003ff].

I didn't use your patch, but this support should now be in the latest
test driver, in Alan Cox's "ac" series of patches.

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
