Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278985AbRKMU5P>; Tue, 13 Nov 2001 15:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279005AbRKMU5F>; Tue, 13 Nov 2001 15:57:05 -0500
Received: from modem-2716.lemur.dialup.pol.co.uk ([217.135.138.156]:40463 "EHLO
	Mail.MemAlpha.cx") by vger.kernel.org with ESMTP id <S278985AbRKMU4s>;
	Tue, 13 Nov 2001 15:56:48 -0500
Posted-Date: Tue, 13 Nov 2001 20:54:38 GMT
Date: Tue, 13 Nov 2001 20:54:37 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Keith Owens <kaos@ocs.com.au>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changed message for GPLONLY symbols 
In-Reply-To: <10870.1005621615@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.21.0111132053180.3058-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith.

>> How about actually checking if the unresolved symbols are available
>> in the GPLONLY area? That would allow you to be more precise.

> I would have to check for all the permutations between module and
> kernel.  With and without symbol versions, with and without gplonly,
> with and without ppc64 function descriptor renaming, with and
> without ia64 function descriptor renaming, ...
> 
> Given the current modutils code, that is just too messy.  The code
> was written for a single set of names and it has been hacked since
> then, with special cases added onto special cases.  The symbol
> handling needs a complete rewrite, which will occur in modutils 2.5.  
> In modutils 2.4 I just ignore the gplonly symbols during symbol
> import unless the module is gpl licenced.  Simpler, if less precise.  
> Since it only affects BOMs, I don't really care that much about
> precise error messages.

Rather than ignore them, set a flag if you see any of them, then make
the message depend on whether the said flag is set or not.

Best wishes from Riley.

