Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266574AbRG1L3W>; Sat, 28 Jul 2001 07:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266577AbRG1L3M>; Sat, 28 Jul 2001 07:29:12 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:11539 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S266574AbRG1L3B>; Sat, 28 Jul 2001 07:29:01 -0400
Message-ID: <3B62F660.FAAB2071@free.fr>
Date: Sat, 28 Jul 2001 13:29:04 -0400
From: PEIFFER Pierre <ppeiffer@free.fr>
X-Mailer: Mozilla 4.77 [fr] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: VIA KT133A / athlon / MMX
In-Reply-To: <E15QE4v-0006R5-00@the-village.bc.nu> <20010728083724.A1571@weta.f00f.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Chris Wedgwood a écrit :
> 
> On Fri, Jul 27, 2001 at 09:19:21PM +0100, Alan Cox wrote:
> 
>     Its heavily tied to certain motherboards. Some people found a
>     better PSU fixed it, others that altering memory settings
>     helped. And in many cases, taking it back and buying a different
>     vendors board worked.
> 
> My guess is its some kind of timing or near-miss on a signal edge, and
> the bios changes relax things so you don't miss whatever it was you
> missed before.
> 

Ok, after reading that, I've tried to see if my BIOS setting changes
were implicated or not. And I've found a winner:
Disabling option "Enhance Chip Performance" makes kernel K7-mmx routines
work fine. Enabling it causes the kernel crash at boot time... (And I
haved it enable)

FYI, according to the user's manual, enabling this option "set the north
bridge chipset timing parameters more aggressively providing higher
system performance" (Default value is 'disable'). I can't say more about
what it does exactly.

I don't know if this will help you to locate the problem, but at least,
Abit's users will be warned...

Thanks for your help !

	Pierre
