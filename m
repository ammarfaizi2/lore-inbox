Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267367AbSLKXje>; Wed, 11 Dec 2002 18:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267370AbSLKXje>; Wed, 11 Dec 2002 18:39:34 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:61199 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267367AbSLKXjd>;
	Wed, 11 Dec 2002 18:39:33 -0500
Date: Wed, 11 Dec 2002 15:45:58 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Confusing help texts?
Message-ID: <20021211234557.GF16615@kroah.com>
References: <20021211224422.GA461@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211224422.GA461@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 11:44:22PM +0100, Pavel Machek wrote:
> Hi!
> 
> + * Prevents any programs running with egid == 0 if a specific USB device
> + * is not present in the system.  Yes, it can be gotten around, but is a
> + * nice starting point for people to play with, and learn the LSM
> + * interface.
> 
> How can you "prevent any program"?

Heh, it's confusing, sorry.

> 
> +         It enables control over processes being created by root users
> +         if a specific USB device is not present in the system.
> 
> Enables control over processes?

Basically, if the USB device is not in the system, then you can not
start any new program as egid = 0.  That's all.

Patches gladly accepted to clean this stuff up :)

thanks,

greg k-h
