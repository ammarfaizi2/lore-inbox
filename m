Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269824AbRHJOuI>; Fri, 10 Aug 2001 10:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269774AbRHJOt7>; Fri, 10 Aug 2001 10:49:59 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:60939 "HELO dvmwest.gt.owl.de")
	by vger.kernel.org with SMTP id <S269766AbRHJOtu>;
	Fri, 10 Aug 2001 10:49:50 -0400
Date: Fri, 10 Aug 2001 16:49:59 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "Linux-Kernel (Lista Correo)" <linux-kernel@vger.kernel.org>
Subject: Re: Can I have a serial display output and a kbd PS/2 input?
Message-ID: <20010810164959.E760@lug-owl.de>
Mail-Followup-To: "Linux-Kernel (Lista Correo)" <linux-kernel@vger.kernel.org>
In-Reply-To: <001b01c12194$a34a3370$66011ec0@frank>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001b01c12194$a34a3370$66011ec0@frank>; from frank@ingecom.net on Fri, Aug 10, 2001 at 02:04:37PM +0200
X-Operating-System: Linux mail 2.4.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-08-10 14:04:37 +0200, Frank Torres <frank@ingecom.net>
wrote in message <001b01c12194$a34a3370$66011ec0@frank>:
> Sorry to be insistent in this point, but perhaps requesting the problem this
> way someone figures out what I am trying to do.
> The display is already configured and sending getty line from inittab waits
> for an input from serial so it doesn't work.
> Any other ideas? This is my last try.

I think something like "console=ttyS1 console=tty0" should do.

This (as boot parameters) means: "output to all defined consoles
and input from tty0" as your keyboard is connected to tty0.

MfG, JBG

