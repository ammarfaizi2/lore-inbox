Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262442AbSKDSE7>; Mon, 4 Nov 2002 13:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262444AbSKDSE7>; Mon, 4 Nov 2002 13:04:59 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:41996 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262442AbSKDSE5>;
	Mon, 4 Nov 2002 13:04:57 -0500
Date: Mon, 4 Nov 2002 10:07:50 -0800
From: Greg KH <greg@kroah.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Miles Lane <miles.lane@attbi.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 -- usbaudio.c: 1882: structure has no member named `bInterfaceClass' in function `snd_usb_create_streams'
Message-ID: <20021104180750.GE6635@kroah.com>
References: <3DC1D768.6000104@attbi.com> <20021101020326.GA13031@kroah.com> <s5hpttlr796.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hpttlr796.wl@alsa2.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 10:53:09AM +0100, Takashi Iwai wrote:
> At Thu, 31 Oct 2002 18:03:26 -0800,
> Greg KH wrote:
> > 
> > On Thu, Oct 31, 2002 at 05:22:48PM -0800, Miles Lane wrote:
> > > CONFIG_SND_DEBUG=y
> > > CONFIG_SND_DEBUG_MEMORY=y
> > > CONFIG_SND_DEBUG_DETECT=y
> > 
> > Turn these off, and the error should go away :)
> > 
> > Sorry, my fault, I'll fix them up.
> 
> i already changed the code on ALSA cvs to use some macros for
> retrieving descriptors from host_* struct, so that it can be compiled
> still on 2.4 kernel with a wrapper header, and fixed the relevant
> part, too.
> hence, you don't need to waste your precious time :)

Thanks for letting me know.

greg k-h
