Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278975AbRJ2ED7>; Sun, 28 Oct 2001 23:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278976AbRJ2EDt>; Sun, 28 Oct 2001 23:03:49 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:36357 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S278975AbRJ2EDj>;
	Sun, 28 Oct 2001 23:03:39 -0500
Message-Id: <5.1.0.14.0.20011029143156.01d62d90@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 29 Oct 2001 15:04:08 +1100
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: SiS drivers (more)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E15x86H-0000GV-00@the-village.bc.nu>
In-Reply-To: <5.1.0.14.0.20011026125325.024517e0@mail.amc.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And more on the SiS7018/Trident audio driver...

Using 2.4.13-ac4, I get...

trident: can't allocate I/O space at 0x1000

.. and then insmod fails with...

/lib/modules/2.4.13-ac4/kernel/drivers/sound/trident.o: init_module: No 
such device

.. which doesn't bode well I guess, least for my situation.


On the SiS FrameBuffer driver front, with 2.4.13-ac4 it comes up with the 
same thing (blank/glowing display), except it flickers a bit more than the 
last driver. Once again, the console and the rest of the machine works, 
just no display output.

Going over the code, this looks a lot more like the core of the driver in 
XFree86 4.1.0, which might prove useful. In fact, I'd guess it's pretty 
much the same code, given some of the names of the functions, etc.

AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

