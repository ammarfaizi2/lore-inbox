Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314128AbSDQPQX>; Wed, 17 Apr 2002 11:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314129AbSDQPQX>; Wed, 17 Apr 2002 11:16:23 -0400
Received: from ns.snowman.net ([63.80.4.34]:30480 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S314128AbSDQPQV>;
	Wed, 17 Apr 2002 11:16:21 -0400
Date: Wed, 17 Apr 2002 11:15:15 -0400 (EDT)
From: <nick@snowman.net>
To: Baldur Norddahl <bbn-linux-kernel@clansoft.dk>
cc: Mike Dresser <mdresser_l@windsormachine.com>, linux-kernel@vger.kernel.org
Subject: Re: IDE/raid performance
In-Reply-To: <20020417140045.GC27648@dark.x.dtu.dk>
Message-ID: <Pine.LNX.4.21.0204171108480.3300-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, Baldur Norddahl wrote:
> Quoting Mike Dresser (mdresser_l@windsormachine.com):
> > On Wed, 17 Apr 2002, Baldur Norddahl wrote:
> Motherboard: Tyan Tiger MPX S2466N
> Chipset: AMD 760MPX
> CPU: Dual Athlon MP 1800+ 1.53 GHz                                              
> Two Promise Technology UltraDMA133 TX2 controllers
> Two Promise Technology UltraDMA100 TX2 controllers
> Matrox G200 AGP video card.
> 1 GB registered DDR RAM
> > Also, with 12 hd's, dual cpu's, etc, what kind of power supply are you
> > using?
> It is a 350W powersupply. I wanted something bigger, but couldn't get it for
> sane prices. I can't rule out that it is overloaded of course. If it is, I
> haven't seen any other symptoms, the system is rock stable so far.
> Baldur
AMD recommends a minimum of 400watts for a dual athlon system
IIRC.  Ignoreing that the startup current on an IBM 5400rpm IDE disk seems
to be about 25-30watts.  Each 1800+ MP puts out 66w of heat, meaning it
uses more than 66w (I couldn't find the power useage stats) for a total of
132 watts, so on boot ignoreing everything but the disks and the chips
you've got 12x25w (for the disks) + 2x66w (for the procs) or about
432watts.  This will go down alot after all your disks spin up, but I'm
amazed your system boots.  Morale of this message:  Don't be a dipshit and
put 12 IDE disks on a single power supply.
	Nick

