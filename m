Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263136AbREaSP3>; Thu, 31 May 2001 14:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263139AbREaSPU>; Thu, 31 May 2001 14:15:20 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:59400 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S263136AbREaSPG>;
	Thu, 31 May 2001 14:15:06 -0400
Date: Thu, 31 May 2001 15:14:44 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: linux-kernel@vger.kernel.org
Cc: twoller@crystal.cirrus.com
Subject: no sound with CS4281 card
Message-ID: <Pine.LNX.4.21.0105311507110.9434-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my notebook (Toshiba 1755) comes with CS4281 built-in,
with all 2.4 kernels I tried this sound card doesn't
generate any sound, or interrupts for that matter.

The driver detects the card fine, but doesn't seem to
be able to do anything with it, on 2.4.5-ac2:

==== /proc/pci ====
  Bus  0, device   8, function  0:
    Multimedia audio controller: Cirrus Logic Crystal CS4281 PCI Audio (rev 1).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=24.
      Non-prefetchable 32 bit memory at 0xfc010000 [0xfc010fff].
      Non-prefetchable 32 bit memory at 0xfc000000 [0xfc00ffff].

==== dmesg ====
cs4281: version v1.13.32 time 15:54:07 May 29 2001
PCI: Enabling device 00:08.0 (0000 -> 0002)
PCI: Found IRQ 5 for device 00:08.0

==== /proc/interrupts ====
  5:          0          XT-PIC  Crystal CS4281

(after trying to play music with mpg123 about 20 times)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

