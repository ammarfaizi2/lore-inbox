Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261808AbSJHKVY>; Tue, 8 Oct 2002 06:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261810AbSJHKVY>; Tue, 8 Oct 2002 06:21:24 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:18450 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S261808AbSJHKVX>; Tue, 8 Oct 2002 06:21:23 -0400
From: "" <simon@baydel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 8 Oct 2002 11:11:44 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: The end of embedded Linux?
CC: linux-kernel@vger.kernel.org
Message-ID: <3DA2BD70.14919.2C6951@localhost>
References: <3DA1CF36.19659.13D4209@localhost>
In-reply-to: <1034022158.26550.28.camel@irongate.swansea.linux.org.uk>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Oct 2002, at 21:22, Alan Cox wrote:

> On Mon, 2002-10-07 at 18:15, simon@baydel.com wrote:
> > a serial port and an interupt controller. What I was trying to explain 
> > was that I would not mind making my code available for these 
> > kernel changes. Although I don't understand why anyone would 
> > want it. Apart from API changes, why do this ? The kernel is not 
> > easily or frequently changed on this type of system. It would bloat 
> > the kernel and I would expect to have to address problems of this 
> > nature myself.  However I would not like to make code available for 
> > the more specialised hardware. 
> 
> That depends how specialized the hardware actually is. I think I've see
> six different non free implementations of 68360 sync serial code around
> all proprietary for example.
> 

The UART and Interrupt controllers in question are built into a gate 
array. I can't see how any external or parts from other vendors 
would be compatible. To get the board to boot Linux I have to 
modify the kernel and lilo. I understand that under the GPL rules I 
would have to make this code available. I am willing to do this but I 
don't see the point. 

There is also more specialized hardware for which I have written 
modules. Although there appears to be some unwritten rule about 
releasing objects, I believe that the GPL rules state that these 
modules must conform to the GPL also, as they contain header 
files. I cannot see how any module can not contain Linux headers 
or headers derived from Linux headers if it is to be loaded on a 
Linux kernel. 

These modules again drive gate array hardware for which nobody 
else will ever have a compatible. Although I would dearly love to 
use Linux as the platform for my project I feel I cannot release this 
code under the GPL.

This is my dilemma and I am sure it is shared by others. For this 
reason I cannot see how anything but an embedded PC with 
applications or a perhaps a very simple hardware device could be 
considered as an opportunity for  embedded Linux. 

I have based these thoughts on my experiences so far. If you feel I 
have drawn an incorrect conclusion I would be grateful for your 
input.


Many Thanks

Simon.



> Also my original comments were much more aimed at the core stuff. People
> who made existing and especially core stuff smaller could send the stuff
> out. Several of us want to compile a CONFIG_TINY option, and suprisingly
> enough small is good on high end boxes. My L1 cache is 8 times faster
> than my L2 cache is 7 times faster than my memory. Or to put it another
> way, going to main memory costs me maybe 100 instructions.
> 
> My Athlon thinks small is good too!
> 


__________________________

Simon Haynes - Baydel 
Phone : 44 (0) 1372 378811
Email : simon@baydel.com
__________________________
