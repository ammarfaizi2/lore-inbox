Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318304AbSHZU3y>; Mon, 26 Aug 2002 16:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318310AbSHZU3y>; Mon, 26 Aug 2002 16:29:54 -0400
Received: from ezri.xs4all.nl ([194.109.253.9]:44243 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S318304AbSHZU3w>;
	Mon, 26 Aug 2002 16:29:52 -0400
Date: Mon, 26 Aug 2002 22:34:08 +0200 (CEST)
From: Eric Lammerts <eric@lammerts.org>
To: Kai-Boris Schad <kschad@ebs.e-technik.uni-ulm.de>
cc: linux-console@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: Q: Howto access the keyboard in a linux system without a graphics
 card ?
In-Reply-To: <200208260943.LAA25845@correo.e-technik.uni-ulm.de>
Message-ID: <Pine.LNX.4.44.0208262228590.10042-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Aug 2002, Kai-Boris Schad wrote:
> I'm trying to set up a small embedded system for gps receiving with a linux
> system.  I want to have the system working without a graphics card - wich
> works well. The Problem I have at the moment is to access the keyboard
> without a graphics card, because the console driver does not start then (
> Also a redirect doesn't work then :-( )
> Is there a way to access the keyboard in this case by a user program ?
> The system recognises the keyboard ( I think Kernel and init) and reacts if
> ctrl-alt-del is pressed.

What would probably work, is to add funkey support to your kernel
(http://rick.vanrein.org/linux/funkey/), define all keys of your
keyboard to be funkeys, and read them from /dev/funkey.

Eric

