Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261819AbSIWOfG>; Mon, 23 Sep 2002 10:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261925AbSIWOe4>; Mon, 23 Sep 2002 10:34:56 -0400
Received: from mta.sara.nl ([145.100.16.144]:13805 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S261855AbSIWOeq>;
	Mon, 23 Sep 2002 10:34:46 -0400
Date: Mon, 23 Sep 2002 16:39:49 +0200
Subject: Re: 2.5.38 on ppc/prep
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: linux-kernel@vger.kernel.org
To: Tom Rini <trini@kernel.crashing.org>
From: Remco Post <r.post@sara.nl>
In-Reply-To: <20020923142951.GO726@opus.bloom.county>
Message-Id: <4FDC416F-CF02-11D6-A08A-000393911DE2@sara.nl>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On maandag, september 23, 2002, at 04:29 , Tom Rini wrote:

> On Mon, Sep 23, 2002 at 02:03:02PM +0200, Remco Post wrote:
>
>> after some tiny fixes to reiserfs and the makefile for prep bootfile
>> (using ../lib/lib.a vs. ../lib/libz.a) I managed to succesfully compile
>> a kernel. It even boots to the point where it frees unused kernel 
>> memory
>> and then stops... this includes succesfully mounting the root
>> filesystem...
>
> What typo exactly?  The only 'lib' in the Makefile
> (arch/ppc/boot/prep/Makefile) is:
> LIBS = ../lib/zlib.a
>

That one exactly... I don't recall calling it a typo, though ;-) I guess 
that is more a relic from when the only lib routines were libz ones and 
we called the lib to be linked libz.a....

There is a simular entry in arch/ppc/boot/openfirmware/Makefile... 
removing the z helped over there as well (don't recall exactly, I'm at 
work now... ) (not that I dare booting Linus's 2.5 tree on my build 
machine, it's falling apart even with stable software....  ;-(


> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
>
--
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167
PGP keys at http://home.sara.nl/~remco/keys.asc

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer 
industry
didn't even foresee that the century was going to end." -- Douglas Adams


