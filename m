Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290329AbSAPBeR>; Tue, 15 Jan 2002 20:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290336AbSAPBeM>; Tue, 15 Jan 2002 20:34:12 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:23688
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S290329AbSAPBdz>; Tue, 15 Jan 2002 20:33:55 -0500
Date: Tue, 15 Jan 2002 20:43:27 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: Unable to compile 2.4.14 on alpha
Message-ID: <20020115204326.B20283@animx.eu.org>
In-Reply-To: <20020115190344.A20283@animx.eu.org> <Pine.LNX.4.44.0201151926580.9754-100000@filesrv1.baby-dragons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.44.0201151926580.9754-100000@filesrv1.baby-dragons.com>; from Mr. James W. Laferriere on Tue, Jan 15, 2002 at 07:51:44PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > just out of curiosity, I have this dac960 controller with alpha 2.70
> > firmware.  I know it says it needs 2.73, but the latest for alpha is 2.70.
> > Any ideas if it'll work or not?
> 	Nope ,  The linux DAC960 driver needs 3.51-0-04 for dual flash .
> 	Or 2.73-0-00 for single flash .  And beleive me Leonard means what
> 	he put in the README.DAC960 file .

I just tried it on my alpha (modifying the source to accept 2.70) and it
appears to work.  atleast I can make a partition, mke2fs it and put files on
it.  I keep getting ecc uncorrectable errors (retryable) frequently.  No,
this isn't DAC's fault because it happens even if I don't load the module. 
I'm assuming it's either 2.4.17 (I doubt it) or the fact I compiled it with
gcc 3.0.3   gcc 2.95.4 wouldn't compile dac960.c

> 	2.73 usability is new to me as when one of these dropped into my
> 	hands all the driver supported was the Dual 3.51... firmware .
> 	Using either of the above will work on Linux ,  BUT not alpha
> 	vms/osf/nt .
> 	The cost for the items from Mylex isn't reasonable imo .  But if
> 	you want it & have a flash burner , Get two just like on the card
> 	now & download the firmware & burn it .  Don't get the XDBA
> 	version as IIRC the alpha boards don't support it .  But do check
> 	if MB you have does .  Might get lucky .

I think I did.  Now if the ecc errors would go away, I'd be happy.  The
machine's crashed many times on my already.

Any ideas on compiling the DAC960 module w/o using gcc 3.0

> > If I loose the contents of everything on this sytem, fine, I have another
> > disk with the system on it so I won't loose anything.  =)
> 
> >  Lab tests show that use of micro$oft causes cancer in lab animals
> 	And other living things !-)  Hth ,  JimL
> 
>        +------------------------------------------------------------------+
>        | James   W.   Laferriere | System    Techniques | Give me VMS     |
>        | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
>        | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
>        +------------------------------------------------------------------+
> 
-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
