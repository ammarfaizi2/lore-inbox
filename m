Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261983AbSJHLT7>; Tue, 8 Oct 2002 07:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbSJHLT6>; Tue, 8 Oct 2002 07:19:58 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:37776 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261983AbSJHLT6>;
	Tue, 8 Oct 2002 07:19:58 -0400
Date: Tue, 8 Oct 2002 13:25:00 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: simon@baydel.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-ID: <20021008132500.A16894@ucw.cz>
References: <3DA1CF36.19659.13D4209@localhost> <1034022158.26550.28.camel@irongate.swansea.linux.org.uk> <3DA2BD70.14919.2C6951@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DA2BD70.14919.2C6951@localhost>; from simon@baydel.com on Tue, Oct 08, 2002 at 11:11:44AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 11:11:44AM +0100, simon@baydel.com wrote:

> The UART and Interrupt controllers in question are built into a gate 
> array. I can't see how any external or parts from other vendors 
> would be compatible. To get the board to boot Linux I have to 
> modify the kernel and lilo. I understand that under the GPL rules I 
> would have to make this code available. I am willing to do this but I 
> don't see the point. 
> 
> There is also more specialized hardware for which I have written 
> modules. Although there appears to be some unwritten rule about 
> releasing objects, I believe that the GPL rules state that these 
> modules must conform to the GPL also, as they contain header 
> files. I cannot see how any module can not contain Linux headers 
> or headers derived from Linux headers if it is to be loaded on a 
> Linux kernel. 
> 
> These modules again drive gate array hardware for which nobody 
> else will ever have a compatible. Although I would dearly love to 
> use Linux as the platform for my project I feel I cannot release this 
> code under the GPL.
> 
> This is my dilemma and I am sure it is shared by others. For this 
> reason I cannot see how anything but an embedded PC with 
> applications or a perhaps a very simple hardware device could be 
> considered as an opportunity for  embedded Linux. 
> 
> I have based these thoughts on my experiences so far. If you feel I 
> have drawn an incorrect conclusion I would be grateful for your 
> input.

Its as easy as: If you want to distribute the binaries, you have to
distribute the source freely. If you don't want to distribute the
binaries nor the code and keep your project private, you don't have to,
under the GPL.

Regarding binary-only kernel modules - well, it's possible, but don't do
that.

-- 
Vojtech Pavlik
SuSE Labs
