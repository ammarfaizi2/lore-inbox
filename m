Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265782AbUFORVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265782AbUFORVu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 13:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265780AbUFORVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 13:21:33 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:51584 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S265777AbUFORVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 13:21:30 -0400
Date: Tue, 15 Jun 2004 17:21:29 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Helge Hafting vs. make menuconfig help
Message-ID: <20040615172129.F6843@beton.cybernet.src>
References: <20040615140206.A6153@beton.cybernet.src> <20040615141039.GF20632@lug-owl.de> <20040615142040.B6241@beton.cybernet.src> <20040615144127.GG20632@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040615144127.GG20632@lug-owl.de>; from jbglaw@lug-owl.de on Tue, Jun 15, 2004 at 04:41:27PM +0200
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > Is it correct what <Help> for CONFIG_INPUT in 2.4.25 says or no?
> 
> At least, it's not really wrong. You need CONFIG_INPUT to be able to do
> something with the HID stuff. However, to have an uniform interface, you

Does HID means always USB?

However when disabling CONFIG_INPUT, the keyboard still works. Is a keyboard
considered a HID or nor?

> may also use the CONFIG_INPUT stuff to access your "normal" (AT / PS/2
> style) keyboard.
> 
> In 2.6.x, that's cleaned up a bit. (Nearly?) all keyboards now push
> their key strokes into the CONFIG_INPUT API, so you really want to have
> CONFIG_INPUT (as long as this isn't some kind of embedded system).

Isn't there some graphical chart (preferrably made in sodipodi ;-) ) that
describes how data are flowing inside the kernel? I have problems visualizing
this.

Cl<
> 
> MfG, JBG
> 
> -- 
>    Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
>    "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
>     fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!
>    ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA));


