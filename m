Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310654AbSDQRHr>; Wed, 17 Apr 2002 13:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310637AbSDQRHq>; Wed, 17 Apr 2002 13:07:46 -0400
Received: from vger.timpanogas.org ([216.250.140.154]:54157 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S310654AbSDQRHn>; Wed, 17 Apr 2002 13:07:43 -0400
Date: Wed, 17 Apr 2002 10:27:22 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: nick@snowman.net, Baldur Norddahl <bbn-linux-kernel@clansoft.dk>,
        Mike Dresser <mdresser_l@windsormachine.com>,
        linux-kernel@vger.kernel.org
Subject: Re: IDE/raid performance
Message-ID: <20020417102722.B26720@vger.timpanogas.org>
In-Reply-To: <Pine.LNX.4.21.0204171108480.3300-100000@ns> <E16xrfQ-0002VF-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From my analysis with 3Ware at 32 drive configurations, you really
need to power the drives from a separate power supply is you have 
more than 16 devices.  They really suck the power during initial 
spinup.

Jeff


On Wed, Apr 17, 2002 at 04:48:20PM +0100, Alan Cox wrote:
> > 432watts.  This will go down alot after all your disks spin up, but I'm
> > amazed your system boots.  Morale of this message:  Don't be a dipshit and
> > put 12 IDE disks on a single power supply.
> 
> I've run a dual athlon set up fully loaded with cards with 10 disks - that
> takes a 550W PSU but works
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
