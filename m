Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130487AbRDSPoq>; Thu, 19 Apr 2001 11:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbRDSPoe>; Thu, 19 Apr 2001 11:44:34 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6273 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130507AbRDSPoW>; Thu, 19 Apr 2001 11:44:22 -0400
Date: Thu, 19 Apr 2001 11:43:40 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Marc Karasek <marc_karasek@ivivity.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Bug in serial.c 
In-Reply-To: <25369470B6F0D41194820002B328BDD27C8E@ATLOPS>
Message-ID: <Pine.LNX.3.95.1010419113845.22016A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2001, Marc Karasek wrote:

> I am doing some embedded development with the 2.4.x series and have noticed
> a few things..
>
[SNIPPED...]
 
> 
> 2) In 2.4.3 the console port using ttySX is broken.  It dumps fine to the
> terminal but when you get to a point of entering data (login, configuration
> scripts, etc) the terminal does not accept any input.  
>

It is not broken. It is used all the while in our embeded systems.
 
> So far I have been able to debug to the point where I see that the kernel is
> receiving the characters from the serial.c driver.  But it never echos them
> or does anything else with them.  I will continue to look into this at this
> end.  
> 

Did you ever initialize the terminal? And I'm not talking about baud-rate.
There is a termios structure of information necessary to configure a
terminal for I/O.

> I was also wondering if anyone else has seen this or if a patch is avail for
> this bug??

You refer to a BUG?  There isn't any of the kind you describe.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


