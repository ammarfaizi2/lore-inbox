Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266667AbUGVLUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266667AbUGVLUJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 07:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUGVLUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 07:20:09 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:53775 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S266667AbUGVLUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 07:20:03 -0400
Date: Thu, 22 Jul 2004 13:20:56 +0200
From: DervishD <raul@pleyades.net>
To: Eva Dominguez <evadom2002@yahoo.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aditional parallel port problems
Message-ID: <20040722112056.GD6148@DervishD>
Mail-Followup-To: Eva Dominguez <evadom2002@yahoo.es>,
	linux-kernel@vger.kernel.org
References: <20040722090106.36880.qmail@web21110.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040722090106.36880.qmail@web21110.mail.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Eva :)

 * Eva Dominguez <evadom2002@yahoo.es> dixit:
>   5. The command "dmesg | grep parport" displays:
> 
>     "parport0: PC-style at 0x378 irq 7 [PCSPP,
> TRISTATE, EPP]" (Is this line telling me the mode of
> the parallel port?? in this case...what does it mean?)
>     "parport1: PC-style at 0x8800 irq 5 [PCSPP,
> TRISTATE, EPP]"
>     "lp0: using parport0 (interrupt-driven)"
>     "lp1: using parport1 (polling)"

    Here I have many VIA chipset PC's, and all of them show the same
problem: the SPP and EPP modes are detected (but only if I give the
proper options, otherwise only SPP works), and ECP is not detected.
The problem is longer to explain properly, but that's more or less.

    I cannot help you (by now...), but I'm trying to isolate and
solve my problem with the help of Dino Klein, and as soon as I have
something, I can contact you.

    Anyway, your card seems to be 'moded' through software, am I
wrong?, so maybe it should work providing in the module options the
io_hi value for the card, so the ECR registers are accessed and you
get ECP. Devices connected to the port shouldn't (IMHO) set the mode
on the port...

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
