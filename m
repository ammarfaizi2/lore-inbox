Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262212AbSKACAA>; Thu, 31 Oct 2002 21:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbSKACAA>; Thu, 31 Oct 2002 21:00:00 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:2820 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262212AbSKAB77>;
	Thu, 31 Oct 2002 20:59:59 -0500
Date: Thu, 31 Oct 2002 18:03:26 -0800
From: Greg KH <greg@kroah.com>
To: Miles Lane <miles.lane@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 -- usbaudio.c: 1882: structure has no member named `bInterfaceClass' in function `snd_usb_create_streams'
Message-ID: <20021101020326.GA13031@kroah.com>
References: <3DC1D768.6000104@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC1D768.6000104@attbi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 05:22:48PM -0800, Miles Lane wrote:
> CONFIG_SND_DEBUG=y
> CONFIG_SND_DEBUG_MEMORY=y
> CONFIG_SND_DEBUG_DETECT=y

Turn these off, and the error should go away :)

Sorry, my fault, I'll fix them up.

thanks,

greg k-h
