Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263128AbTCYRpd>; Tue, 25 Mar 2003 12:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbTCYRpd>; Tue, 25 Mar 2003 12:45:33 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:10770 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263128AbTCYRpc>;
	Tue, 25 Mar 2003 12:45:32 -0500
Date: Tue, 25 Mar 2003 09:56:03 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>
Subject: Re: i2c driver changes for 2.5.66; adding w83781d support.
Message-ID: <20030325175603.GG15823@kroah.com>
References: <1048582394.4774.7.camel@workshop.saharact.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048582394.4774.7.camel@workshop.saharact.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 10:53:14AM +0200, Martin Schlemmer wrote:
> Hi
> 
> I am interested in this, but I only have LKML at work.  Mind
> sending me all the changes to 2.5.66 as one bulk patch?

They should be all in the patch-2.5.66-bk1 file on kernel.org right now.

> Also, I did some initial patch to get w83781d support in, but
> it very rough.  I will try to get to doing it according to your
> 'How to convert i2c adapter drivers into good kernel code' ...
> Who do I sent it to if completed ?

I have a port of this driver in my kernel tree, if you really want to
use it right now.  But I'd recommend waiting on converting the chip
drivers until we get the sysfs interface conversion done, otherwise we
will have to go back and modify all files again :)

See my other post about the eeprom.c driver for more info on the sysfs
changes needed for i2c chip drivers, it isn't as simple.

But if you really want to do it, great.  Send it on to lkml, and
probably the sensors list.  You can cc me if you want to.

thanks,

greg k-h
