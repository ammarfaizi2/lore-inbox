Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265714AbUBBRI7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 12:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265740AbUBBRI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 12:08:59 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:34821 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265714AbUBBRI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 12:08:57 -0500
Message-ID: <401E8536.5000805@techsource.com>
Date: Mon, 02 Feb 2004 12:13:26 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: John Bradford <john@grabjohn.com>, chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
References: <4017F2C0.4020001@techsource.com> <200401291211.05461.chakkerz@optusnet.com.au> <40193136.4070607@techsource.com> <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk> <40193A67.7080308@techsource.com> <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk> <4019472D.70604@techsource.com> <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk> <40195AE0.2010006@techsource.com> <Pine.GSO.4.58.0402011123010.20933@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0402011123010.20933@waterleaf.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Geert Uytterhoeven wrote:
> On Thu, 29 Jan 2004, Timothy Miller wrote:
> 
>>Ok, so, how about this idea:
>>
>>- Small Xilinx FPGA, 16M of RAM, and a DAC on a board.
>>- AGP 2X
>>- Up to 2048x2048 resolution at 8, 16, and 32 bpp.
>>- Acceleration ONLY for solid fills and bitblts on-screen.
> 
> 
> Sounds OK to me.

To you.  But if you are the only customer, that doesn't make for very 
large sales volumes.

> 
> 
>>Given that so little is accelerated, there is no point in putting more
>>than the viewable framebuffer on the card, hense the 16 megs.  It would
>>probably actually HURT performance to cache pixmaps on the card.
>>
>>
>>Oh, there's one thing I forgot.  It would have to support VGA.  There is
>>a VGA core on opencores.org that we could use, but its logic area would
>>probably push up the FPGA cost so that the board was in the $100 range.
>>  Probably more.
> 
> 
> Why support legacy VGA? It makes things more complex and expensive, and doesn't
> give us much, especially for a SoC.

It's all about console support in a PC.

BTW, What is SoC?

