Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285329AbRLGAXT>; Thu, 6 Dec 2001 19:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285341AbRLGAXA>; Thu, 6 Dec 2001 19:23:00 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:6663 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S285329AbRLGAWy>;
	Thu, 6 Dec 2001 19:22:54 -0500
Date: Thu, 6 Dec 2001 16:21:55 -0800
From: Greg KH <greg@kroah.com>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: jonathan@daria.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Q: device(file) permissions for USB
Message-ID: <20011206162155.R2710@kroah.com>
In-Reply-To: <fa.ljcupnv.1ghotjk@ifi.uio.no> <664.3c0fd1b7.a66fa@trespassersw.daria.co.uk> <20011206223050.179cd30e.rene.rebe@gmx.net> <20011206152721.M2710@kroah.com> <20011207004521.19a131d4.rene.rebe@gmx.net> <20011206160055.O2710@kroah.com> <20011207011134.04c2a4af.rene.rebe@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011207011134.04c2a4af.rene.rebe@gmx.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 08 Nov 2001 18:50:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 01:11:34AM +0100, Rene Rebe wrote:
> 
> Ok I did not searched this far. But this way you also change the nodes for
> USB hard-discs, net-interfaces, ... to 666 - the same insecure as my find
> solotion ...

I was making a simple script, to match your simple defvsd line.  Yes,
you can (and should) make this more complex.  See the linux-hotplug
mailing list for a recent discussion by the gphoto developers about
this very problem.

> OK. Might be well for backward-compatibility - but the devfs solution
> would be a very nice option.

Will not happen.

thanks,

greg k-h
