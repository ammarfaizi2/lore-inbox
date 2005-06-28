Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVF1JJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVF1JJM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVF1JJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 05:09:12 -0400
Received: from nome.ca ([65.61.200.81]:21155 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S261469AbVF1JJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 05:09:06 -0400
Date: Tue, 28 Jun 2005 02:08:53 -0700
From: Mike Bell <kernel@mikebell.org>
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050628090852.GA966@mikebell.org>
Mail-Followup-To: Mike Bell <kernel@mikebell.org>, Greg KH <greg@kroah.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org
References: <20050624081808.GA26174@kroah.com> <20050625234305.GA11282@kroah.com> <20050627071907.GA5433@mikebell.org> <200506271735.50565.dtor_core@ameritech.net> <20050627232559.GA7690@mikebell.org> <20050628074015.GA3577@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628074015.GA3577@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 12:40:15AM -0700, Greg KH wrote:
> > 1) Predictable, canonical device names are a Good Thing.
> 
> And impossible for the kernel to generate given hotpluggable devices.

Bull. It's clear I'm talking about per-subsystem, not having individual
devices show up with the same name each time. Or are you suggesting that
hotplug might somehow turn my keyboard into a hard drive?

> I don't accept it, and neither does anyone else.

So then explain this to me, I've got a GUI sound player, on first
invocation it displays a list of sound cards installed on the system,
allows the user to select one, and then plays the sound file. How is it
supposed to do that if the device nodes for sound card 0 could be named
anything? I can get a list of sound cards from /proc/asound or
/sys/class/sound, but unless the sound card device nodes are predictably
named there's no way to find them short of searching every node in /dev.
