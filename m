Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265663AbUFOOWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265663AbUFOOWR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 10:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbUFOOV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 10:21:27 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:46720 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S265655AbUFOOUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 10:20:43 -0400
Date: Tue, 15 Jun 2004 14:20:40 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Helge Hafting vs. make menuconfig help
Message-ID: <20040615142040.B6241@beton.cybernet.src>
References: <20040615140206.A6153@beton.cybernet.src> <20040615141039.GF20632@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040615141039.GF20632@lug-owl.de>; from jbglaw@lug-owl.de on Tue, Jun 15, 2004 at 04:10:39PM +0200
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 04:10:39PM +0200, Jan-Benedict Glaw wrote:
> On Tue, 2004-06-15 14:02:06 +0000, Karel Kulhavý <clock@twibright.com>
> wrote in message <20040615140206.A6153@beton.cybernet.src>:
> > Hello
> > 
> > Helge Hafting says that CONFIG_INPUT is about HID in general.
> > make menuconfig help in 2.4.25 says that CONFIG_INPUT is about USB HID only.
> 
> HID is used in conjunction of USB input devices (USB mice, USB
> keyboards, ...).
> 
> CONFIG_INPUT only gives you an API where you can process input events
> with. For instance, look at the atkbd.c, sunkbd.c or lkkbd.c drivers.
> They all send key strokes into the Input API (activated by
> CONFIG_INPUT), but none of them actually uses USB (but the PS/2 keyboard
> port or normal serial ports with non-standard plugs).

Is it correct what <Help> for CONFIG_INPUT in 2.4.25 says or no?

Cl<
> 
> MfG, JBG
> 
> -- 
>    Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
>    "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
>     fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!
>    ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA));


