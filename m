Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKBWus>; Thu, 2 Nov 2000 17:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129250AbQKBWui>; Thu, 2 Nov 2000 17:50:38 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:16646 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129076AbQKBWub>; Thu, 2 Nov 2000 17:50:31 -0500
Message-ID: <3A01EED6.DB47198A@timpanogas.org>
Date: Thu, 02 Nov 2000 15:46:46 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <Pine.LNX.4.21.0011010122160.18143-100000@elte.hu> <39FF5332.7C862223@timpanogas.org> <20001102031546.B10806@cerebro.laendle> <20001101212835.A2425@vger.timpanogas.org> <20001102043332.A27126@fuji.laendle> <3A0195DA.DDEBAC51@timpanogas.org> <20001102194323.D2790@cerebro.laendle> <3A01CBB5.48C3094A@timpanogas.org> <20001102214903.F2790@cerebro.laendle> <3A01E71A.778BD898@timpanogas.org> <20001102232210.H2790@cerebro.laendle> <3A01ECD2.76DE10FF@timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"Jeff V. Merkey" wrote:

In the example of an AGI generating code fragment, while I described the
sequence of creating the AGI with immediate address usage correctly
(i.e. if you load an address into a register then immediately attempt to
use it, it will generate an AGI), I failed to put the register in the
coding example.  

A couple of folks are testing the gcc compiler for AGI problems as a
result of this post, and I am posting the corrected code for their
tests.

This code fragment will generate an AGI condition:

mov   eax, addr
mov   [eax].offset, ebx

You can do it with any register combination, BTW, eax and abx are
provided as examples.  For those who are monitoring the code produced by
gcc, this is the example to use to test generate an AGI correctly.

:-)

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
