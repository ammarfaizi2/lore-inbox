Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289806AbSAKAjr>; Thu, 10 Jan 2002 19:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289808AbSAKAjh>; Thu, 10 Jan 2002 19:39:37 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:13989 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S289806AbSAKAj2>; Thu, 10 Jan 2002 19:39:28 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
In-Reply-To: <E16OpWJ-00061v-00@the-village.bc.nu>
From: Ronald Wahl <Ronald.Wahl@informatik.tu-chemnitz.de>
Date: 11 Jan 2002 01:39:26 +0100
In-Reply-To: <E16OpWJ-00061v-00@the-village.bc.nu>
Message-ID: <m2sn9dn2kh.fsf@goliath.csn.tu-chemnitz.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2002 00:26:07 +0000 (GMT), Alan Cox wrote:

>> > hard to get emulations right. I grant that this wasn't helped by the fact
>> > the gcc x86 folks also couldnt read the pentium pro manual correctly.
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^       
>> What do you mean with this? Explain, please!

> gcc told to generate i686 binaries uses cmov unconditionally. The intel
> PPro handbook explicitly says that cmov must be checked for.

The compiler doesn't know, where the binary runs later. Or do you mean,
that it has to insert some code that checks for the existance of these
instructions during program start? Ok that would be a solution, but how
do you do this for libraries that are not run in itself?

>> myself but I have also some older machines here that have a k6 or a
>> pentium. For mistake I installed the wrong rpm and had a non working
>> system. An emulation for such cases would be a _real_ feature at least

> So you have a buggy rpm program. Get the rpm program fixed so it correctly
> stops you from doing that.

Maybe, ok. But why should such a mistake prevent me from workin with the
system when it could be easily catched? Ok, the emulation code may not
be easy, I dunno, but the infrastructure for emulation of instructions
is already there (FPU emulation). To say its the admins fault is easy
but the costs of automatically catching such errors are little in
respect of the benefit you get. A running system is always better than
a unusable one even if it was the admins fault.

ron

-- 
/\/\  Dipl.-Inf. Ronald Wahl                /\/\        C S N         /\/\
\/\/  ronald.wahl@informatik.tu-chemnitz.de \/\/  ------------------  \/\/
/\/\  http://www.tu-chemnitz.de/~row/       /\/\  network and system  /\/\
\/\/  GnuPG/PGP key available               \/\/    administration    \/\/
