Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265777AbUFORWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265777AbUFORWz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 13:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265778AbUFORWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 13:22:54 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:52352 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S265777AbUFORWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 13:22:46 -0400
Date: Tue, 15 Jun 2004 17:22:43 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HID vs. Input Core
Message-ID: <20040615172243.G6843@beton.cybernet.src>
References: <20040615143525.18034.qmail@web81309.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040615143525.18034.qmail@web81309.mail.yahoo.com>; from dtor_core@ameritech.net on Tue, Jun 15, 2004 at 07:35:25AM -0700
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > CONFIG_INPUT Help says
> > "Say Y here if you want to enable any of the following options for USB
> > Human Interface Device (HID) support".
> > 
> > Helge Hafting from linux-kernel says that CONFIG_INPUT controls enabling
> > input devices at
> > all. These two statements are in a direct contradiction. (See above).
> > 
> 
> Well, kind of... Helge Hafting is 100% correct in 2.6 sense where all
> input devices have been switched to use input core. In 2.4 only USB input
> devices use input core while other devices (like PS/2 mouse) use legacy
> interfaces like /dev/psaux.
> 
> So for 2.4 you need to enable HID to turn on hardware driver for HID
> devices and you want to enable input core to allow data from your USB
> device to be awailabe to userspace.

So that enabling HID without input core in 2.4 doesn't make sense
and enabling input core without HID in 2.4 doesn't make sense too?

Cl<
