Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132807AbREEPbU>; Sat, 5 May 2001 11:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132825AbREEPbL>; Sat, 5 May 2001 11:31:11 -0400
Received: from 4dyn183.delft.casema.net ([195.96.105.183]:40204 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S132807AbREEPbC>; Sat, 5 May 2001 11:31:02 -0400
Message-Id: <200105051529.RAA16274@cave.bitwizard.nl>
Subject: Re: dhcp problem with realtek 8139 clone with rh 7.1
In-Reply-To: <E14vj1d-0007es-00@the-village.bc.nu> from Alan Cox at "May 4, 2001
 06:05:51 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat, 5 May 2001 17:29:47 +0200 (MEST)
CC: Adam <adam@vbfx.com>, linux-kernel@vger.kernel.org,
        "Michael K. Johnson"@cave.bitwizard.nl, johnsonm@redhat.com,
        jgarzik@mandrakesoft.com
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > I've had the same problem with the 8139too drivers and DHCP.  The reason
> > I figure it must be the drivers is because in the 2.4.3 kernel, I'm able
> > to use the 8139too drivers with DHCP without any problems.  In 2.4.4 it
> > locks my system.
 
> Multiple such reports - seems the 8139too update broke stuf - any
> ideas Jeff, should I revert to the 2.4.3 one ?

Ack!

I have two diskless systems that with 2.4.4 end up with VERY slow
network interfaces. I then do a 

	cp ../linux-2.4.2.clean/drivers/net/8139too.c drivers/net

and rebuild. Fixes my problems.... 

Jeff, my offer of acess to a box that has this problem still stands.

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
