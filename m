Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268398AbRG3HTL>; Mon, 30 Jul 2001 03:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268406AbRG3HTC>; Mon, 30 Jul 2001 03:19:02 -0400
Received: from [195.139.250.10] ([195.139.250.10]:40204 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S268398AbRG3HSt>;
	Mon, 30 Jul 2001 03:18:49 -0400
Message-ID: <3B65099E.8004F9E5@scali.no>
Date: Mon, 30 Jul 2001 09:15:42 +0200
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gav <gavbaker@ntlworld.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: VIA KT133A / athlon / MMX
In-Reply-To: <E15QEP3-0006TF-00@the-village.bc.nu> <01072904032900.04737@box.penguin.power>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Gav wrote:
> Just FYI, I've been running 2.4.7-pre6 for a few weeks on a Abit-KT7-a
> (hpt370) that uses the KT133/VIA chipset, with a 1.33Ghz Athlon and the
> kernel compiled for an Athlon.
> 
> The machine is now rock solid. I've given it the usual tests, k7burn for 5
> hours, cp'ing 30G+ across drives a few times etc, and all is good.
> 
> The broken sound (crackle/pop) with my SB128PCI (same problem as SBLive)
> still didn't go away though, but enabling PCI DRAM PREFETCH on the VT8363
> Bus-PCI Bridge does cure it. This took me a while to find as I can't set this
> in my bios, but powertweak came to the rescue.
> 
> While DRAM Prefetch is supposed to be an option to increase performance, my
> sound is totally unusable without this set. I've heard numerous people
> explain the same problem and it would be interesting to find out if this
> cures their sound troubles too. If this is the case, is this something that
> belongs in quirks, or is it too hardware specific? and would enabling this by
> default hurt anything anyway? Or is this just masking the underlaying problem
> ?

Hmm, I think "DRAM Prefetch" is the one you _don't_ want to turn on, because (and correct
me if i'm wrong) it's causing all the problems with the IDE controller (data trashing).

Regards,
-- 
  Steffen Persvold               Systems Engineer
  Email : mailto:sp@scali.no     Scali AS (http://www.scali.com)
  Tlf   : (+47) 22 62 89 50      Olaf Helsets vei 6
  Fax   : (+47) 22 62 89 51      N-0621 Oslo, Norway
