Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312920AbSDGUuw>; Sun, 7 Apr 2002 16:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313471AbSDGUuw>; Sun, 7 Apr 2002 16:50:52 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.17]:19498 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S312920AbSDGUuv>; Sun, 7 Apr 2002 16:50:51 -0400
Message-ID: <3CB0B124.70423121@chello.nl>
Date: Sun, 07 Apr 2002 22:50:47 +0200
From: Segher Boessenkool <segher@chello.nl>
Reply-To: segher@chello.nl
X-Mailer: Mozilla 4.73C-CCK-MCD {C-UDP; EBM-APPLE} (Macintosh; U; PPC)
X-Accept-Language: en
MIME-Version: 1.0
To: benh@kernel.crashing.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David N. Welton" <davidw@dedasys.com>, linux-kernel@vger.kernel.org
Subject: Re: forth interpreter as kernel module
In-Reply-To: <E16tHSB-00078F-00@the-village.bc.nu> <20020405181627.22453@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



benh@kernel.crashing.org wrote:

> Yes, an OpenFirmware emulator would be interesting. It would allow to
> softboot OF PCI cards on non-OF machines, and would allow to implement
> properly resume from sleep on some desktop G4s that will power off the
> PCI bus during sleep (some cards need to be re-softbooted, like video
> ones, and in some case, you really want the vendor firmware to run).

I'm writing a full OF implementation for OpenBios.  It will also be
able to run in user space, which might be a better solution for things
like softboot (and besides, it makes development a lot easier).

It is supposed to be fully portable across all architectures that
run Linux.

Check out module Paflof from OpenBios CVS.

http://www.freiburg.linux.de/OpenBIOS/

Nothing very mature yet, so don't get too excited now.


Cheers,

Segher

