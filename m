Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130926AbRAaLUU>; Wed, 31 Jan 2001 06:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131085AbRAaLUL>; Wed, 31 Jan 2001 06:20:11 -0500
Received: from d14144.upc-d.chello.nl ([213.46.14.144]:47332 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S130926AbRAaLT5>;
	Wed, 31 Jan 2001 06:19:57 -0500
Date: Wed, 31 Jan 2001 12:19:52 +0100
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 -- Unresolved symbols in radio-miropcm20.o
Message-ID: <20010131121952.A11947@fenrus.demon.nl>
In-Reply-To: <3A772D3C.CB62DD4F@megapath.net> <m14NsuB-000OZJC@amadeus.home.nl> <20010131045520.B32636@cadcamlab.org> <20010131120712.A11819@fenrus.demon.nl> <14967.62433.949844.559264@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14967.62433.949844.559264@wire.cadcamlab.org>; from peter@cadcamlab.org on Wed, Jan 31, 2001 at 05:15:45AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 05:15:45AM -0600, Peter Samuelson wrote:
> 
> [Arjan van de Ven]
> > This doesn't take into account the case where someone says "n" to
> > CONFIG_SOUND.
> 
> So move the test outside the 'if [ "$CONFIG_SOUND" = "y" ]'.  The
> principle is the same.  

That won't work, unless you also want to force the soundlayer on people. 
Which is unacceptable. period. I've been over this when I added the #ifdef
to the 2.2 kernel, and nobody came up with a better idea.
At least using the #ifdef + #error, the user gets a proper notification that
his kernel won't work and what he can do about it.

Greetings,
   Arjan van de Ven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
