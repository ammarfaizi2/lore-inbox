Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130905AbQKKAkW>; Fri, 10 Nov 2000 19:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131744AbQKKAkM>; Fri, 10 Nov 2000 19:40:12 -0500
Received: from [216.161.55.93] ([216.161.55.93]:33262 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S130905AbQKKAkG>;
	Fri, 10 Nov 2000 19:40:06 -0500
Date: Fri, 10 Nov 2000 16:40:07 -0800
From: Greg KH <greg@wirex.com>
To: Gerald Haese <Gerald.Haese@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mouse stops working
Message-ID: <20001110164006.E1229@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	Gerald Haese <Gerald.Haese@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <00111101012003.01860@dose>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00111101012003.01860@dose>; from Gerald.Haese@gmx.de on Sat, Nov 11, 2000 at 01:01:20AM +0100
X-Operating-System: Linux 2.2.17-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 01:01:20AM +0100, Gerald Haese wrote:
> Hi, ...
> 
> the following problem is not a new one (for me):
> 
> I'm using an SMP system. Everything works fine and (absolutely) stable - 
> exept my USB mouse :-( It's the USB version of the Wacom Graphire tablet. The 
> mouse works great for some minutes or up to half an hour and it generates a 
> lot of interrupts during this time ... And now the mouse stops working. No 
> interrupt is generated. The USB printer does not work any more. Unloading and 
> reloading of the USB related modules does not help :-( No interrupts are 
> registered for USB (seen in /proc/interrupts).

What is the output of /proc/interrupts?  Is USB sharing an interrupt
with anything else?

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
