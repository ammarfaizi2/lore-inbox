Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280746AbRKGCOK>; Tue, 6 Nov 2001 21:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280743AbRKGCOA>; Tue, 6 Nov 2001 21:14:00 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:36873 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S280742AbRKGCNn>;
	Tue, 6 Nov 2001 21:13:43 -0500
Date: Tue, 6 Nov 2001 19:13:21 -0800
From: Greg KH <greg@kroah.com>
To: James Funkhouser <news@funkhouser.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Seg fault when syncing Sony Clie 760 with USB cradle
Message-ID: <20011106191321.B18025@kroah.com>
In-Reply-To: <20011106183409.A16895@cableone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011106183409.A16895@cableone.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 10 Oct 2001 02:07:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2001 at 06:34:09PM -0600, James Funkhouser wrote:
>  Everything still works fine with my USB Visor.  One of the things
> that caught my eye is "Sony Clie 4.0 converter".  Unlike the 710,
> the 760 runs PalmOS 4.1, rather than 4.0.  Perhaps this has
> something to do with it??

Yes, but the Clie didn't change the product id for the two OS versions,
so the driver thinks they are the same :(

See my previous post about the real problem that is happening here.  I
should have a patch for this soon.

thanks,

greg k-h
