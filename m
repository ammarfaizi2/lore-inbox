Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317336AbSFLXoC>; Wed, 12 Jun 2002 19:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317375AbSFLXoB>; Wed, 12 Jun 2002 19:44:01 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:28173 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317336AbSFLXn7>;
	Wed, 12 Jun 2002 19:43:59 -0400
Date: Wed, 12 Jun 2002 16:39:55 -0700
From: Greg KH <greg@kroah.com>
To: jt@hpl.hp.com
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Re : ANN: Linux 2.2 driver compatibility toolkit
Message-ID: <20020612233955.GC17306@kroah.com>
In-Reply-To: <20020610174050.A21783@bougret.hpl.hp.com> <3D07D022.5030106@mandrakesoft.com> <20020612162714.A24255@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 15 May 2002 22:01:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 04:27:14PM -0700, Jean Tourrilhes wrote:
> 	For me, the problem between 2.5.X and 2.4.X is the USB API
> which has significantely changed (urb_submit anyone ?). I end up
> having two quite different version of irda-usb to maintain. But
> probably USB in 2.5.X. is too much a moving target for you to include
> in your package.

Heh, this is the first complaint I've had about this, which is quite
surprising :)

I'll be putting most of the 2.5 USB api changes into 2.4 once
2.4.19-final comes out, so then you can go back to having 1 version of
your driver (if you like that kind of thing, personally I don't.)

thanks,

greg k-h
