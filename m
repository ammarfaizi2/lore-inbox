Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132613AbRC1XUr>; Wed, 28 Mar 2001 18:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132615AbRC1XUi>; Wed, 28 Mar 2001 18:20:38 -0500
Received: from linas.org ([207.170.121.1]:33263 "HELO backlot.linas.org")
	by vger.kernel.org with SMTP id <S132613AbRC1XUT>;
	Wed, 28 Mar 2001 18:20:19 -0500
Subject: Re: mouse problems in 2.4.2 -> lost byte
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Wed, 28 Mar 2001 17:19:33 -0600 (CST)
Cc: Gunther.Mayer@t-online.de (Gunther Mayer), linas@linas.org,
   linux-kernel@vger.kernel.org
In-Reply-To: <20010328235913.A6994@suse.cz> from "Vojtech Pavlik" at Mar 28, 2001 11:59:13 PM
From: linas@linas.org
X-Hahahaha: hehehe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010328231933.53ECF1B7A5@backlot.linas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's been rumoured that Vojtech Pavlik said:
> On Wed, Mar 28, 2001 at 08:31:52PM +0200, Gunther Mayer wrote:
> > linas@linas.org wrote:
> > > It's been rumoured that Gunther Mayer said:
> > > > linas@linas.org wrote:
> > > > > 
> > > > > I am experiencing debilitating intermittent mouse problems & was about
> > > >
> > > > This is easily explained: some byte of the mouse protocol was lost.
> > > 
> > Getting resync right is not as easy as detecting zero bytes. You
> > should account for wild protocol variations in the world wide mouse
> > population, too.
> 
> The new input psmouse driver can resync when bytes are lost and also
> shouldn't lose any bytes if there are not transmission problems on the
> wire. But this is 2.5 stuff.

umm linux kernel 2.5? Umm, given that a stable linux 2.6/3.0 might be
years away ... and this seems 'minor', wouldn't it be better to 
submit this as a teeny-weeny new kind of mouse device driver as a 2.4.x
patch?  e.g. CONFIG_MOUSE_PSAUX_SUPERSYNC or something?   I mean this
cant be more than a few hundred lines of code? Requireing no other
changes to the kernel?

--linas
