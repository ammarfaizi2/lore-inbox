Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131977AbRARF20>; Thu, 18 Jan 2001 00:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131979AbRARF2Q>; Thu, 18 Jan 2001 00:28:16 -0500
Received: from dsl-45-165.muscanet.com ([208.164.45.165]:2181 "EHLO grace")
	by vger.kernel.org with ESMTP id <S131931AbRARF2F>;
	Thu, 18 Jan 2001 00:28:05 -0500
Date: Wed, 17 Jan 2001 04:36:19 -0600
From: Josh Myer <josh@joshisanerd.com>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Joel Franco Guzmán <joel@gds-corp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 128M memory OK, but with 192M sound card es1391 trouble
Message-ID: <20010117043619.B23406@grace>
In-Reply-To: <Pine.LNX.4.30.0101172037310.1309-100000@thor.gds-corp.com> <20010118002551.C883@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010118002551.C883@werewolf.able.es>; from jamagallon@able.es on Wed, Jan 17, 2001 at 17:25:51 -0600
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're probably just hearing electrical noise from the memory buss; try
moving the 128 stick to the slot you put the 64 in (if you can) and run
that way -- you'll probably hear it there too.

I get something similiar to this with my SB Live (!... damn marketroids) on
a BP6 with 192MB as well. In my case, it's not during DSP use per se, but
during memory activity. Try dragging a window around in X and listen for
buzzing.

My guess is that JA's console player doesn't move around as much memory as
the gnome one (imagine that), therefore produces less memory noise.
--
/jbm, but you can call me Josh. Really, you can.
       "car. snow. slippery. wheee. 
        dead josh. car slipped on ice."
 -- Manda explaining my purchase of kitty litter

On Wed, 17 Jan 2001 17:25:51 J . A . Magallon wrote:
> 
> On 2001.01.18 Joel Franco Guzmán wrote:
> > 1. 128M memory OK, but with 192M the sound card generate a noise while
> > use the DSP.
> .. 
> > the problem: The sound card generates a toc.. toc.. toc .. toc...while
> > playing a sound using the DSP of the soundcard. Two "tocs"/sec
> > aproxiumadetely.
> > 
> > 
.
> I have noticed something similar. If I start gqmpeg from the command line
> in
> a terminal (rxvt), sounds fine. If I start it from the icon in the gnome
> panel, it makes that 'toc toc' noise you describe. ????
> (I know it sounds strange, but real...)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
