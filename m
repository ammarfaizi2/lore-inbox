Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVCGVeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVCGVeQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVCGVaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:30:52 -0500
Received: from av3-2-sn4.m-sp.skanova.net ([81.228.10.113]:54425 "EHLO
	av3-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261767AbVCGV3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:29:30 -0500
To: dtor_core@ameritech.net
Cc: Henrik Persson <root@fulhack.info>, linux-kernel@vger.kernel.org
Subject: Re: Touchpad "tapping" changes in 2.6.11?
References: <422C539A.4040407@fulhack.info>
	<d120d500050307055522415fb3@mail.gmail.com>
	<422C7CF3.9080609@fulhack.info>
	<d120d50005030708365a4917c5@mail.gmail.com>
From: Peter Osterlund <petero2@telia.com>
Date: 07 Mar 2005 22:29:26 +0100
In-Reply-To: <d120d50005030708365a4917c5@mail.gmail.com>
Message-ID: <m37jkjdu15.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Mon, 07 Mar 2005 17:10:27 +0100, Henrik Persson <root@fulhack.info> wrote:
> > Dmitry Torokhov wrote:
> > > On Mon, 07 Mar 2005 14:14:02 +0100, Henrik Persson <root@fulhack.info> wrote:
> > >
> > >>I noticed that the ALPS driver was added to 2.6.11, a thing that alot of
> > >>people probably like, but since my touchpad (Acer Aspire 1300XV) worked
> > >>perfectly before (like, 2.6.10) and now the ALPS driver disables
> > >>'hardware tapping', wich makes it hard to tap. I commented out the
> > >>disable-tapping bits in alps.c and now it's working like a charm again.
> > >
> > > Could you please try 2.6.11-mm1. It has bunch of Peter Osterlund's
> > > patches that shoudl improve the situation with tapping.
> > 
> > Well, -mm1 didn't quite agree with my savage gfx drivers. But I'm
> > booting with psmouse.proto=exps now, and it's working the way I'm used
> > to now.
> > 
> > The Aspire 1300-series is quite different from the 1350 ones.. The
> > touchpad on the 1300 will work like a charm without the synaptics driver
> > (but no fancy stuff is supported, I guess). Before you could boot and be
> > happy without the synaptics driver, now you probably have to install the
> > synaptics driver to be happy.. Maybe that's not so good. :)
> > 
> > Could this touchpad use the "exps" proto as default and then you could
> > reconfigure if you want to use the ALPS driver..?
> 
> We (well Peter and Vojtech mostly as I don't have ALPS touchpad in my
> box) are trying to make ALPS work as it was working before even
> without Synaptics X driver without any additional options, please bear
> with us.

I have some touchpad related patches in my tree, which I have uploaded
here:

        http://web.telia.com/~u89404340/patches/touchpad/2.6.11/

All of these patches are already in -mm I think.

> Still I think having Synaptics driver installed is the best way in the
> end simply because it has a lot of knobs so one can adjust tpouchpad's
> behavior to his/her liking. Maybe once distibutions start packaging
> and activating it by default it will be less of an issue.

Fedora Core 3 already does that if I remember correctly.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
