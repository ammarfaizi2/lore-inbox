Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264656AbUE2SXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264656AbUE2SXk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 14:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264663AbUE2SXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 14:23:40 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:51076 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264656AbUE2SXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 14:23:39 -0400
Date: Sat, 29 May 2004 20:23:57 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Message-ID: <20040529182357.GA25315@ucw.cz>
References: <20040528154307.142b7abf.akpm@osdl.org> <MPG.1b22c626ab9fcdc79896a5@news.gmane.org> <20040529154443.GA15651@ucw.cz> <200405291218.30617.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405291218.30617.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 12:18:30PM -0500, Dmitry Torokhov wrote:

> > Module (or kernel cmdline) parameters are not a good way to go, because
> > they cannot be changed at runtime. For mouse models, sysfs will be used
> > (when I get to implementing sysfs support for serio and input layers),
> > and most keyboards don't need any special options, except for scrolling
> > keyboards - setkeycode is enough to teach the driver about the special
> > scancodes.
> > 
> 
> I have a patch that sysfsifies all serio drivers but not serio ports yet...
> I wanted to get everything in shape before showing it, but if you are
> interested I can rediff against the current.

Show it. ;)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
