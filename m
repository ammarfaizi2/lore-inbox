Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317450AbSFMEfr>; Thu, 13 Jun 2002 00:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317451AbSFMEfq>; Thu, 13 Jun 2002 00:35:46 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:59405 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317450AbSFMEfp>;
	Thu, 13 Jun 2002 00:35:45 -0400
Date: Wed, 12 Jun 2002 21:31:35 -0700
From: Greg KH <greg@kroah.com>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: Re : ANN: Linux 2.2 driver compatibility toolkit
Message-ID: <20020613043134.GA18360@kroah.com>
In-Reply-To: <20020610174050.A21783@bougret.hpl.hp.com> <3D07D022.5030106@mandrakesoft.com> <20020612162714.A24255@bougret.hpl.hp.com> <20020612233955.GC17306@kroah.com> <20020612165030.A24311@bougret.hpl.hp.com> <20020612235747.GD17306@kroah.com> <20020612203620.K16859@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 16 May 2002 03:27:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 08:36:20PM -0400, Johannes Erdfelt wrote:
> On Wed, Jun 12, 2002, Greg KH <greg@kroah.com> wrote:
> > 	- change usb_submit_urb and usb_alloc_urb apis
> 
> Do you think it's a good idea to change the API in a stable kernel
> series?

When it fixes the real problems these api changes offer, yes.
I will be fixing up all of the in-kernel references, so I don't see any
problem this can cause.  Any out-of-kernel drivers will just have to
deal with it :)

thanks,

greg k-h
