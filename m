Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281362AbRKEVxH>; Mon, 5 Nov 2001 16:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281372AbRKEVw7>; Mon, 5 Nov 2001 16:52:59 -0500
Received: from gate.mesa.nl ([194.151.5.70]:779 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S281362AbRKEVwm>;
	Mon, 5 Nov 2001 16:52:42 -0500
Date: Mon, 5 Nov 2001 22:52:40 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Stephane Jourdois <stephane@tuxfinder.org>
Cc: LKLM <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMM BIOS on Dell i8100
Message-ID: <20011105225240.A25654@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <20011105100346.A1511@emeraude.kwisatz.net> <20011105130954.A24310@joshua.mesa.nl> <20011105180124.B17203@emeraude.kwisatz.net> <20011105182029.C24310@joshua.mesa.nl> <20011105183724.A17663@emeraude.kwisatz.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011105183724.A17663@emeraude.kwisatz.net>; from stephane@tuxfinder.org on Mon, Nov 05, 2001 at 06:37:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 06:37:24PM +0100, Stephane Jourdois wrote:
> On Mon, Nov 05, 2001 at 06:20:29PM +0100, Marcel J.E. Mol wrote:
> > I checked /proc/i8k while pressing the buttons next to the
> > power button and they work fine. 
> Did you use my patch ? I think that Jeff Garzik would appreciate
> to have a proof that it still works on i8000 ;-)

Yup, just did it. I see no difference in funtionality with your
patch added.
 
> > So what's left is to tie these buttons to some function so that
> > I can control the soundvolume/dvd player wherever I am i X...
> Then now you should download i8kutils-1.1 from :
> 	http://people.debian.org/~dz/i8k/
> Marcello's utils are just what you are looking for now.
> in fact, i8kbuttons.c will enable volume controll, i8kmon will
> display a very usefull fans status (and *YES* ! you can start them
> with a click :-)).

Arg... I already downloaded this and made the module from it as i did
not want to compile the pre8 kernel yet.  (I only had to run the i8kmon
using 'wish i8kmon' as it complained about 'Tk'; this is latest Rawhide)

> Just a little hint for i8kbuttons :
> I suggest that you run :
> ./i8kbuttons --up "aumix -v +5" --down "aumix -v -5"

Great, Just add "--mute "aumix -v 0" to mute, but I do prefer the gmix
way that restores original volume level when the mutebutton is pressed
again but that probaly only works as gmix is running all the time...
Getting OT but does anyone know if you can sent events to gmix to do
volume control?
 
> Finally, as I told Massimo this morning, I just *love* to start my
> fans just to here the little noise and see the proc temp decreasing.
> (try a cat /dev/zero to increase quickly your cpu temp and enjoy !)
> I think you'll appreciate those tools...
> I can imagine your joy, I'm just thinking to me yesterday evening ;-)

I sure do! It is so nice to have a choice to do things quickly/easy with
the keyboard or with the mouse...

-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
