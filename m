Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267441AbTACHJT>; Fri, 3 Jan 2003 02:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267444AbTACHJT>; Fri, 3 Jan 2003 02:09:19 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46841 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267441AbTACHJS>; Fri, 3 Jan 2003 02:09:18 -0500
Date: Fri, 3 Jan 2003 08:17:46 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Steven Barnhart <sbarn03@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.54, PNP, SOUND] compile error
Message-ID: <20030103071746.GA6114@fs.tum.de>
References: <87hecr4w6x.fsf@jupiter.jochen.org> <pan.2003.01.02.16.04.00.473440@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2003.01.02.16.04.00.473440@softhome.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 11:04:17AM -0500, Steven Barnhart wrote:
> On Thu, 02 Jan 2003 12:39:50 +0100, Jochen Hein wrote:
> 
> > 
> > It compiled well without PNP, now with the following PNP in .config:
> > 
> > #
> > # Plug and Play support
> > #
> > CONFIG_PNP=y
> > CONFIG_PNP_NAMES=y
> > CONFIG_PNP_CARD=y
> > CONFIG_PNP_DEBUG=y
> > 
> > #
> > # Protocols
> > #
> > CONFIG_ISAPNP=y
> > CONFIG_PNPBIOS=y
> 
> I got the same problem. I am guessing maybe a missing include file?

No, this driver isn't converted to the new PNP code.

> Steven

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

