Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263212AbREaUdD>; Thu, 31 May 2001 16:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263209AbREaUcn>; Thu, 31 May 2001 16:32:43 -0400
Received: from cs6625192-102.austin.rr.com ([66.25.192.102]:9992 "EHLO
	mail1.cirrus.com") by vger.kernel.org with ESMTP id <S263221AbREaUcc>;
	Thu, 31 May 2001 16:32:32 -0400
Message-ID: <973C11FE0E3ED41183B200508BC7774C0124F2D7@csexchange.crystal.cirrus.com>
From: "Woller, Thomas" <twoller@crystal.cirrus.com>
To: "'Rik van Riel'" <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: RE: no sound with CS4281 card
Date: Thu, 31 May 2001 15:33:19 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll send the latest driver that I have via separate email.  Toshiba refuses
to supply equipment, and there are some design issues with Toshiba laptops.
I recently sent a driver to another Toshiba owner and he had good luck with
the latest driver. I have never seen any Toshiba laptop not generate sound
with any cs4281 driver at any time ( :) ), but that certainly doesn't rule
out the 2.4.5-ac2 not working on a Toshiba 1755.  I am pulling the 2.4.5-ac6
source now and will try on a 4281 ref card.  
mpg123 the only app not working?
Thanks for the input
tom

 -----Original Message-----
From: 	Rik van Riel [mailto:riel@conectiva.com.br] 
Sent:	Thursday, May 31, 2001 1:15 PM
To:	linux-kernel@vger.kernel.org
Cc:	twoller@crystal.cirrus.com
Subject:	no sound with CS4281 card

Hi,

my notebook (Toshiba 1755) comes with CS4281 built-in,
with all 2.4 kernels I tried this sound card doesn't
generate any sound, or interrupts for that matter.

The driver detects the card fine, but doesn't seem to
be able to do anything with it, on 2.4.5-ac2:

==== /proc/pci ====
  Bus  0, device   8, function  0:
    Multimedia audio controller: Cirrus Logic Crystal CS4281 PCI Audio (rev
1).
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
