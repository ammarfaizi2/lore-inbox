Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932747AbVJ3GrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbVJ3GrL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 01:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932761AbVJ3GrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 01:47:11 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:60304 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932747AbVJ3GrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 01:47:10 -0500
Message-Id: <200510300326.j9U3QXeT027101@inti.inf.utfsm.cl>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-kernel@vger.kernel.org, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: SPARC64: Configuration offers keyboards that don't make sense 
In-Reply-To: Message from Dmitry Torokhov <dtor_core@ameritech.net> 
   of "Sat, 29 Oct 2005 01:07:53 CDT." <200510290107.53493.dtor_core@ameritech.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sun, 30 Oct 2005 00:26:33 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> On Friday 28 October 2005 19:06, Horst von Brand wrote:
> > Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> > > On Fri, 2005-10-28 17:09:31 -0300, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:

[...]

> > > > Also, configuring this one gives a non-functional keyboard (the
> > > > machine is running, I can log in over SSH, but keypresses have no
> > > > effect at all).

> > > Did the serial port register serio ports?

> > How can I find this out?

> Just post your dmesg..

Nothing relevant I can see.

>                        Or ssh into it and poke around /sys/bus/serio...

Got /sys/sun/bus/serio/drivers/subkbd/ with several files inside

> Sun keyboard can be autodetected AFAIK so you don't need to fiddle with
> inputattach.

The setup works for the shipped Aurora kernel, but to compile that
configuration would take a few days...

>              Do you have sunsu or sunzilog drivers selected?

SUNZILOG is module, and is not loaded right now. No serials in use.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
