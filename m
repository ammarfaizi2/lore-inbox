Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbTC0S2M>; Thu, 27 Mar 2003 13:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261271AbTC0S2M>; Thu, 27 Mar 2003 13:28:12 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:40968 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261258AbTC0S2L>;
	Thu, 27 Mar 2003 13:28:11 -0500
Date: Thu, 27 Mar 2003 10:38:21 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Jochen Hein <jochen@jochen.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.66] slab corruption
Message-ID: <20030327183820.GH32667@kroah.com>
References: <871y0uhriz.fsf@echidna.jochen.org> <20030326133021.43f75e1c.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326133021.43f75e1c.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 01:30:21PM -0800, Andrew Morton wrote:
> Jochen Hein <jochen@jochen.org> wrote:
> >
> > 
> > This is when shutting down.  I have the two patches from Jack Simmons
> > for the illegal context and the broken cursor applied and nothing
> > else.
> > 
> > uhci-hcd 00:07.2: remove, state 3
> > usb usb1: USB disconnect, address 1
> 
> There's some nastiness in the USB disconnect code.  Does David Brownell's
> patch help?

Sad thing is, this patch breaks other things :(
I'm still trying to track this one down...

thanks,

greg k-h
