Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289794AbSAKALN>; Thu, 10 Jan 2002 19:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289796AbSAKALD>; Thu, 10 Jan 2002 19:11:03 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:19107 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S289794AbSAKAKx>; Thu, 10 Jan 2002 19:10:53 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
In-Reply-To: <E16Oocq-0005tX-00@the-village.bc.nu>
From: Ronald Wahl <Ronald.Wahl@informatik.tu-chemnitz.de>
Date: 11 Jan 2002 01:08:39 +0100
In-Reply-To: <E16Oocq-0005tX-00@the-village.bc.nu>
Message-ID: <m2wuypn3zs.fsf@goliath.csn.tu-chemnitz.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002 23:28:48 +0000 (GMT), Alan Cox wrote:

>> is it possible to include an emulation for the CMOV* (and possible other
>> i686 instructions) for processors that dont have these (k6, pentium
>> etc.)? I think this should work like the fpu emulation. Even if its slow

> The kernel isnt there to fix up the fact authors can't read. Its also very
> hard to get emulations right. I grant that this wasn't helped by the fact
> the gcc x86 folks also couldnt read the pentium pro manual correctly.
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^       
What do you mean with this? Explain, please!

> If you have a static linked program install the right version. RPMv4
> even knows about cmov and i686 rpms.

The problem I had is the following: I make all of my linux binaries
myself but I have also some older machines here that have a k6 or a
pentium. For mistake I installed the wrong rpm and had a non working
system. An emulation for such cases would be a _real_ feature at least
more than a pinguin boot logo (if one uses the framebuffer console).
I think a stable and possible self correcting [1] system should be the aim
of a modern OS. Maybe I will have a look on implementing the emulation
but I thought I'll find someone here who has done this already (or is
willing to do so).

ron

[1] This means catching most or all errors and correct them as good as
    possible. Only a running system is a good system. ;-)

-- 
/\/\  Dipl.-Inf. Ronald Wahl                /\/\        C S N         /\/\
\/\/  ronald.wahl@informatik.tu-chemnitz.de \/\/  ------------------  \/\/
/\/\  http://www.tu-chemnitz.de/~row/       /\/\  network and system  /\/\
\/\/  GnuPG/PGP key available               \/\/    administration    \/\/
