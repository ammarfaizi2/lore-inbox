Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129277AbRBCSN7>; Sat, 3 Feb 2001 13:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129567AbRBCSNt>; Sat, 3 Feb 2001 13:13:49 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:49086 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S129277AbRBCSNh>; Sat, 3 Feb 2001 13:13:37 -0500
Message-Id: <l0313031db6a1fa3ba470@[192.168.239.105]>
In-Reply-To: <Pine.LNX.4.30.0102031824030.14465-100000@cola.teststation.com>
In-Reply-To: <3A7C3C6E.7296.82EE32@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 3 Feb 2001 18:13:25 +0000
To: Urban Widmark <urban@teststation.com>, <T.Stewart@student.umist.ac.uk>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: DFE-530TX with no mac address
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>You can always try writing all the registers with "good" values.

No good - nothing actually changes except 16 bits at 0x6C, and that doesn't
change to anything useful.

>> Is there a reset 'thing' for thses chips, that sets them back to
>> factory tests (like switching them off)?
>[snip]
>> So.....How do I go about playing this game?
>
>You find the reset "thing". Maybe there is better documentation somewhere.
>Maybe your bios allows you to reset something on reboots.
>
>The pdf document has a few things that you can play with, SRST, INIT,
>STRT.

Already played with those, to no avail.

I think the PDF is talking about a different revision of the chip to ours -
I'm seeing some bits set which are marked "reserved" in the PDF, and some
reserved bits are clear.

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
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
