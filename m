Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290162AbSAKX12>; Fri, 11 Jan 2002 18:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290163AbSAKX1U>; Fri, 11 Jan 2002 18:27:20 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:14 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S290162AbSAKX1L>;
	Fri, 11 Jan 2002 18:27:11 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200201112326.g0BNQvR318985@saturn.cs.uml.edu>
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 11 Jan 2002 18:26:57 -0500 (EST)
Cc: rth@twiddle.net (Richard Henderson), alan@lxorguk.ukuu.org.uk (Alan Cox),
        Ronald.Wahl@informatik.tu-chemnitz.de (Ronald Wahl),
        linux-kernel@vger.kernel.org
In-Reply-To: <E16PAld-0000c9-00@the-village.bc.nu> from "Alan Cox" at Jan 11, 2002 11:07:21 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> [somebody]

>> Eh?  -march=i686 *asserts* that cmov is available.
>
> So why is it called "i686" when the intel i686 machine definition
> says its optional ? Its just the naming that seems odd
>
>> What's the point of optimizing an IF to a cmov if I have
>> to insert another IF to see if I can use cmov?
>
> I've always wondered. Intel made the instruction optional
> yet there isnt an obvious way to do runtime fixups on it

This may design-by-committee in action, or corporate rules
that are hard to defy. Don't worry about it. Intel will
never produce a new x86-compatible chip without cmov.
Nobody else will either.

Gee, when was the last time Intel removed something from the
instruction set? An old 80286 instruction comes to mind, but
that was a super-CISC mess that was really specific to the
implementation. Anything really useful that was ever removed?

