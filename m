Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136103AbRECM2u>; Thu, 3 May 2001 08:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136774AbRECM2k>; Thu, 3 May 2001 08:28:40 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:32501 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S136103AbRECM2Y> convert rfc822-to-8bit; Thu, 3 May 2001 08:28:24 -0400
Message-Id: <l03130313b716fd8bf5d6@[192.168.239.105]>
In-Reply-To: <3AF135F0.6ED58AB3@home.com>
In-Reply-To: <Pine.LNX.4.10.10105012333400.18414-100000@coffee.psychology.mcmaster.ca>
 <l0313030eb715db09b49f@[192.168.239.105]>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date: Thu, 3 May 2001 13:25:33 +0100
To: Seth Goldberg <bergsoft@home.com>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: DISCOVERED! Cause of Athlon/VIA KX133 Instability
Cc: Moses McKnight <m_mcknight@surfbest.net>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm using an Abit KT7 board (KT133) and my new 1GHz T'bird (running 50-60°C
>> in a warm room) is giving me no trouble.  This is with the board and RAM
>> pushed as fast as it will go without actually overclocking anything...  and
>> yes, I do have Athlon/K7 optimisations turned on in my kernel (2.4.3).
>>
>
>  I wonder if the KT133A (which is what the IWILL KK266 is based on)
>differences
>a could be a source of the problem.  My FSB is at plain old 100 MHz
>since I
>have regular PC100 SDRAM.  Overclocked, or not, I get the same results.
>I,
>too, had an ABIT KA7[-RAID] and it was rock solid.  So much for "if it's
>not broke, don't fix it" -- I should have listened to my gf, but that's
>the life of an upgrader ;)...  In general the IWILL got great reviews at
>a
>number of reliable hardware review sites, and hey, it doesn't lock up in
>windows ;) (ok don't flame me for that ;)).

Maybe, but the IWILL board is the only one we've heard about problems with.
The Abit KT7A (which also has the KT133A chipset and is otherwise identical
to the KT7) would appear to run smoothly, although I don't actually *have*
one of those.  Probably the Windows drivers turn off some feature of the
IWILL board which is known to be flaky.

I suggest setting *everything* in the BIOS to the "most conservative"
settings and seeing if the problem persists.  If so, then it can't be a
hardware-speed-limitation problem, and there's clearly something we have to
turn off "manually".  Also, try running memtest86 and see if that is
capable of triggering the problem.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


