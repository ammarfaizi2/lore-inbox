Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290074AbSAKUA1>; Fri, 11 Jan 2002 15:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290077AbSAKUAK>; Fri, 11 Jan 2002 15:00:10 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:52598 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S290074AbSAKT7y>; Fri, 11 Jan 2002 14:59:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ronald.Wahl@informatik.tu-chemnitz.de (Ronald Wahl)
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
Date: Fri, 11 Jan 2002 20:59:45 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16Oocq-0005tX-00@the-village.bc.nu>
In-Reply-To: <E16Oocq-0005tX-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020111195946.38C35142E@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 11. January 2002 00:28, Alan Cox wrote:
> > is it possible to include an emulation for the CMOV* (and possible other
> > i686 instructions) for processors that dont have these (k6, pentium
> > etc.)? I think this should work like the fpu emulation. Even if its slow
>
> The kernel isnt there to fix up the fact authors can't read. Its also very
> hard to get emulations right. I grant that this wasn't helped by the fact
> the gcc x86 folks also couldnt read the pentium pro manual correctly.

But it shouldn't crash, if the wrong architecture is chosen. (Different
problem, I know) Perfect solution would be emulate them all, but at least
an simple error message (please eject CPU, and put in a XXX one) would be 
sufficient, IMHO. 

> If you have a static linked program install the right version. RPMv4
> even knows about cmov and i686 rpms.

Hans-Peter
