Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290082AbSAKUFj>; Fri, 11 Jan 2002 15:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290085AbSAKUFa>; Fri, 11 Jan 2002 15:05:30 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:42128 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S290082AbSAKUFT>; Fri, 11 Jan 2002 15:05:19 -0500
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
In-Reply-To: <E16Oocq-0005tX-00@the-village.bc.nu>
	<20020111195946.38C35142E@shrek.lisa.de>
From: Ronald Wahl <Ronald.Wahl@informatik.tu-chemnitz.de>
Date: 11 Jan 2002 21:05:17 +0100
In-Reply-To: <20020111195946.38C35142E@shrek.lisa.de>
Message-ID: <m21ygwmz5u.fsf@goliath.csn.tu-chemnitz.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2002 20:59:45 +0100, Hans-Peter Jansen wrote:

> On Friday, 11. January 2002 00:28, Alan Cox wrote:
>> > is it possible to include an emulation for the CMOV* (and possible other
>> > i686 instructions) for processors that dont have these (k6, pentium
>> > etc.)? I think this should work like the fpu emulation. Even if its slow
>> 
>> The kernel isnt there to fix up the fact authors can't read. Its also very
>> hard to get emulations right. I grant that this wasn't helped by the fact
>> the gcc x86 folks also couldnt read the pentium pro manual correctly.

> But it shouldn't crash, if the wrong architecture is chosen. (Different
> problem, I know) Perfect solution would be emulate them all, but at least
> an simple error message (please eject CPU, and put in a XXX one) would be 
> sufficient, IMHO. 

A message occurs already: "Illegal instruction". But this is not
really a help.

ron

-- 
/\/\  Dipl.-Inf. Ronald Wahl                /\/\        C S N         /\/\
\/\/  ronald.wahl@informatik.tu-chemnitz.de \/\/  ------------------  \/\/
/\/\  http://www.tu-chemnitz.de/~row/       /\/\  network and system  /\/\
\/\/  GnuPG/PGP key available               \/\/    administration    \/\/
