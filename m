Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270506AbRHWVbH>; Thu, 23 Aug 2001 17:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270521AbRHWVa5>; Thu, 23 Aug 2001 17:30:57 -0400
Received: from urc1.cc.kuleuven.ac.be ([134.58.10.3]:55534 "EHLO
	urc1.cc.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S270506AbRHWVam>; Thu, 23 Aug 2001 17:30:42 -0400
Message-ID: <3B85760B.2A25641F@pandora.be>
Date: Thu, 23 Aug 2001 23:30:51 +0200
From: Bart Vandewoestyne <Bart.Vandewoestyne@pandora.be>
Organization: MyHome
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: nl-BE, nl, en, de
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: assembler -> linux system calls
In-Reply-To: <Pine.LNX.3.95.1010823170837.23731A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Thu, 23 Aug 2001, Bart Vandewoestyne wrote:
> 
> > I am trying to write a linux device driver for a data acquisition
> > card.  The little homepage for my project is at
> > http://mc303.ulyssis.org/heim/
> > There is already a DOS driver available, and I am trying to port the
> > DOS code right now.
> >
> > Somewhere in the DOS code, there is some assembler code included:

-> assembler code at: http://mc303.ulyssis.org/heim/downloads/INPL.ASM

> File:
> /usr/include/asm/io.h
> ...contains most of the I/O macros you need.

Hmm... I looked through that file, and it only talks about inl and
outl functions.  I guess the 'inpl' from the assembler code can be
mapped to 'inl' from /usr/include/asm/io.h and the same for 'outpl',
but what about 'inplI' and 'outplI' from the assembler code?  My
assembler skills ar zero, so I don't know if i can also just replace
those by 'inl' and 'outl' from the linux source...

Greetzzz,
mc303

-- 
Ing. Bart Vandewoestyne			 Bart.Vandewoestyne@pandora.be
Hugo Verrieststraat 48			       GSM: +32 (0)478 397 697
B-8550 Zwevegem			 http://users.pandora.be/vandewoestyne
----------------------------------------------------------------------
"Any fool can know, the point is to understand." - Albert Einstein
