Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310153AbSCGREU>; Thu, 7 Mar 2002 12:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310403AbSCGREL>; Thu, 7 Mar 2002 12:04:11 -0500
Received: from [151.17.201.167] ([151.17.201.167]:51466 "EHLO mail.teamfab.it")
	by vger.kernel.org with ESMTP id <S310153AbSCGRDz>;
	Thu, 7 Mar 2002 12:03:55 -0500
Message-ID: <3C879E01.B2BFAFCD@teamfab.it>
Date: Thu, 07 Mar 2002 18:06:09 +0100
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-i586-SMP-modular i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Linux 2.2.21pre[23]
In-Reply-To: <E16j0fe-0002m9-00@the-village.bc.nu> <3C879558.A727E265@teamfab.it> <20020307173948.I29587@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Thu, Mar 07, 2002 at 05:29:12PM +0100, Luca Montecchiani wrote:
>  > > EIP:    0010:[<c0278bc1>]
>  > this is -> x86_serial_nr_setup
> 
>  Ok, this doesn't make any sense at all.

You're right x86_serial_nr_setup() is c0278bc8
while c0278bc1 didn't exist in my system.map sorry!

>  Your original report says the last thing you saw before the oops was
>  "CPU serial number disabled."
> 
>  The code which prints that should run way later than x86_serial_nr_setup
>  I'll go stare at the code a bit, and see if something jumps out.

thanks,
luca
