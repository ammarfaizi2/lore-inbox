Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135601AbREBPxq>; Wed, 2 May 2001 11:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135599AbREBPxh>; Wed, 2 May 2001 11:53:37 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:1278 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S135607AbREBPxR> convert rfc822-to-8bit; Wed, 2 May 2001 11:53:17 -0400
Message-Id: <l0313030eb715db09b49f@[192.168.239.105]>
In-Reply-To: <3AEFB8BE.5050007@surfbest.net>
In-Reply-To: <Pine.LNX.4.10.10105012333400.18414-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date: Wed, 2 May 2001 16:47:51 +0100
To: Moses McKnight <m_mcknight@surfbest.net>, linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: DISCOVERED! Cause of Athlon/VIA KX133 Instability
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> the only general issue is that kx133 systems seem to be difficult
>> to configure for stability.  ugly things like tweaking Vio.
>> there's no implication that has anything to do with Linux, though.
>
>
>When I reported my problem a couple weeks back another fellow
>said he and several others on the list had the same problem,
>and as far as I can tell it is *only* with the IWILL boards.
>When I compiled with k7 optimizations I'd get all kinds of oopses
>and panics and never fully boot.  They were different every time.
>When any of the lesser optimizations are used I have no problems.
>My memory is one 256MB Corsair PC150 dimm, CPU is a Thunderbird 850,
>and mobo is an IWILL KK266 (KT133A).  The CPU runs between 35°C
>and 40°C.

I'm using an Abit KT7 board (KT133) and my new 1GHz T'bird (running 50-60°C
in a warm room) is giving me no trouble.  This is with the board and RAM
pushed as fast as it will go without actually overclocking anything...  and
yes, I do have Athlon/K7 optimisations turned on in my kernel (2.4.3).

Out of interest, what FSB are you using for your machine?  I understand the
difference between the KT133 and the KT133A is that the latter supports a
266MHz FSB for the Athlon rather than 200MHz.  Since your CPU is running
cool, I doubt you've managed to accidentally o/c it, but nevertheless this
is a possibility...

The 266MHz FSB does require considerably higher standards in board
construction though, so it could be that IWILL have managed to do a shoddy
job on that end.

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


