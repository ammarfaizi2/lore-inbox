Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269936AbRHJQDl>; Fri, 10 Aug 2001 12:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269937AbRHJQDb>; Fri, 10 Aug 2001 12:03:31 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:16570 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S269936AbRHJQDT>; Fri, 10 Aug 2001 12:03:19 -0400
Date: Fri, 10 Aug 2001 17:03:21 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Linux-Kernel (Lista Correo)" <linux-kernel@vger.kernel.org>
Subject: Re: Can I have a serial display output and a kbd PS/2 input?
Message-ID: <20010810170321.D27072@flint.arm.linux.org.uk>
In-Reply-To: <001b01c12194$a34a3370$66011ec0@frank> <20010810164959.E760@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010810164959.E760@lug-owl.de>; from jbglaw@lug-owl.de on Fri, Aug 10, 2001 at 04:49:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2001 at 04:49:59PM +0200, Jan-Benedict Glaw wrote:
> I think something like "console=ttyS1 console=tty0" should do.
> 
> This (as boot parameters) means: "output to all defined consoles
> and input from tty0" as your keyboard is connected to tty0.

No, you're missing his point.

He wants a getty (not only kernel console) to take input from the
keyboard, and output through a serial port, which can't be done
presently.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

