Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135604AbRAWBOh>; Mon, 22 Jan 2001 20:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135940AbRAWBOS>; Mon, 22 Jan 2001 20:14:18 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:50441 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S135604AbRAWBOO>;
	Mon, 22 Jan 2001 20:14:14 -0500
Date: Mon, 22 Jan 2001 17:14:24 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Jinnah Dylan Hosein <jdh@iostream.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: Odd Question: pc_keyb as a module?
In-Reply-To: <Pine.LNX.4.10.10101221929330.23022-100000@hfuhruhurr.vindigo.com>
Message-ID: <Pine.LNX.4.21.0101221711130.328-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have a need to use pc_keyb as a module. I am using off the shelf ps/2
> keyboard chipsets as chording keyboard controllers. This uses a modified
> pc_keyb.c that see's multiple key presses and translates them into
> scancodes that are then handled by the rest of the keyboard driver.
> 
> It would make life much better if I were able to have one pc_keyb.o module
> that was the kernel original and another that has the chording code. That
> way I could swap them, and I wouldn't need to rebuild and install an 
> entirely kernel everytime I make a tweak to the chording code.
> 
> I'm not entirely sure home much trouble this would cause. But any help or
> direction would be much appreciated.

Hi!
 
   Actually we have something like that in our developement tree. We have
converted over the PS/2 chipset and their devices to the Input API. The
drivers are completely modular. With a USB keybaord this would be really
handy. If have more questions just ask. Take a look at

http://linuxconsole.sourceforge.net




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
