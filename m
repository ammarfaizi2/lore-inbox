Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266665AbSLJGqI>; Tue, 10 Dec 2002 01:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266678AbSLJGqI>; Tue, 10 Dec 2002 01:46:08 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:6412 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266665AbSLJGqH>;
	Tue, 10 Dec 2002 01:46:07 -0500
Date: Mon, 9 Dec 2002 22:52:47 -0800
From: Greg KH <greg@kroah.com>
To: Miles Lane <miles.lane@attbi.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: sound/built-in.o: In function `snd_complete_urb': undefined reference to `usb_submit_urb'
Message-ID: <20021210065247.GA4248@kroah.com>
References: <1039501666.7838.4.camel@bellybutton.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039501666.7838.4.camel@bellybutton.attbi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 10:27:47PM -0800, Miles Lane wrote:
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=y
> CONFIG_SND_SEQUENCER=y
> # CONFIG_SND_SEQ_DUMMY is not set
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=y
> CONFIG_SND_PCM_OSS=y
> CONFIG_SND_SEQUENCER_OSS=y
> # CONFIG_SND_RTCTIMER is not set
> CONFIG_SND_VERBOSE_PRINTK=y
> CONFIG_SND_DEBUG=y
> # CONFIG_SND_DEBUG_MEMORY is not set
> CONFIG_SND_DEBUG_DETECT=y
> CONFIG_SND_EMU10K1=y
> 
> CONFIG_SND_USB_AUDIO=y
> 
> #
> # USB support
> #
> CONFIG_USB=m

Change this to "y" and it should fix your problem.

thanks,

greg k-h
