Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136421AbRAJVFI>; Wed, 10 Jan 2001 16:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136437AbRAJVE6>; Wed, 10 Jan 2001 16:04:58 -0500
Received: from chaos.analogic.com ([204.178.40.224]:12672 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S136420AbRAJVEh>; Wed, 10 Jan 2001 16:04:37 -0500
Date: Wed, 10 Jan 2001 15:52:19 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jonathan Earle <jearle@nortelnetworks.com>
cc: "'Linux Kernel List'" <linux-kernel@vger.kernel.org>,
        "'Linux Network List'" <linux-net@vger.kernel.org>
Subject: Re: Porting network driver to 2.4.0
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDC78@zcard00g.ca.nortel.com>
Message-ID: <Pine.LNX.3.95.1010110155123.14197A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Jonathan Earle wrote:

> Hey all,
> 
> Still working with kernel 2.4.0-test9 (other things we use require it for
> now), and I was looking at a driver for a Znyx zx346q network card that I
> grabbed from the znyx.com website.  The driver is for a 2.2.x kernel, but
> figuring I'd try it anyway, downloaded and tried to build it.  It choked on
> three struct net_device entries which are no longer present:
>                                                   
> zxe.c:1200: structure has no member named `tbusy'
> zxe.c:1201: structure has no member named `interrupt'
> zxe.c:1202: structure has no member named `start'
> ...
> make[2]: *** [zxe.o] Error 1                              
> 
> Where do I go from here?  Is there info somewhere to help with this?  Is
> this a bigger job than it looks on the surface?
> 
> Cheers!
> Jon

You may be lucky. Comment out all references to those structure members
and see if it works!


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
