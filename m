Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277395AbRJJUKP>; Wed, 10 Oct 2001 16:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277400AbRJJUKK>; Wed, 10 Oct 2001 16:10:10 -0400
Received: from h226-58.adirondack.albany.edu ([169.226.226.58]:6879 "EHLO
	bouncybouncy.net") by vger.kernel.org with ESMTP id <S277395AbRJJUJw>;
	Wed, 10 Oct 2001 16:09:52 -0400
Date: Wed, 10 Oct 2001 16:10:12 -0400
From: Justin A <justin@bouncybouncy.net>
To: Dieter N?tzel <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Message-ID: <20011010161012.A5967@bouncybouncy.net>
In-Reply-To: <200110100358.NAA17519@isis.its.uow.edu.au> <20011010120009.851921E7C9@Cantor.suse.de> <20011010153653.Q726@athlon.random> <20011010155953Z277295-760+23277@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011010155953Z277295-760+23277@vger.kernel.org>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 05:37:40PM +0200, Dieter N?tzel wrote:
> Am Mittwoch, 10. Oktober 2001 05:25 schrieb Justin A:
> > On Tue, Oct 09, 2001 at 08:36:56PM -0400, safemode wrote:
> > > Heavily io bound processes (dbench 32)  still causes something as light as
> > > an mp3 player to skip, though.   That probably wont be fixed intil 2.5,
> > > since 
> >
> > What buffer size are you using in your mp3 player?  I have xmms set to
> > 5000ms or so and it never skips.
> 
> OK, I'll give xmms with this buffer size a go, too.
> 
> > mpg321(esd or oss) also never skips no matter what I do,
> 
> Do you have link to the mpg321 (oss) version for me?

It should be in the same version:

   -o dt    Set output devicetype to dt [esd,alsa,arts,sun,oss]
   
> 
> > but the original mpg123-oss will with even light load
> > on the cpu/disk.
> 
> I get the hiccup with mpg123 and noatun (artsd, KDE-2.2.1).

Have you tried the -b option in mpg123?

-b n  output buffer: n Kbytes [0]

Even maxed out it has no effect on the quality of the playback.
> 
> >
> > This is with 2.4.10-ac9+preempt on an athlon 700
> 
> Here with Linus tree.
> 
> -Dieter

This behavior(xmms and mpg321 fine, mpg123 skipping) has always been the
same for me. xmms was a more reliable player on my pentium 100.  It may
just be a better design in mpg321 and xmms.

-Justin

