Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316434AbSEOQge>; Wed, 15 May 2002 12:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316435AbSEOQgd>; Wed, 15 May 2002 12:36:33 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:21511 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316434AbSEOQg3>;
	Wed, 15 May 2002 12:36:29 -0400
Date: Wed, 15 May 2002 08:35:18 -0700
From: Greg KH <greg@kroah.com>
To: Martin Devera <devik@cdi.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG and OOPS in USB-OHCI again
Message-ID: <20020515153518.GC24420@kroah.com>
In-Reply-To: <Pine.LNX.4.44.0205151742210.12674-100000@luxik.cdi.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 17 Apr 2002 14:28:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 05:52:29PM +0200, Martin Devera wrote:
> Hi Greg,
> 
> I read post of some people having problems with OHCI. Well
> I'm having them too.
> We use pwc.o module (without closed-source compression support)
> on two machines with OHCI add-on card.
> It fails regulary (twice a day) with:
> BUG at usb-ohci.h:464 and it panics. With onboard UHCI it works
> well !! When I sumarized other posts on the list we can see that
> there was the same problems with OHCI+modem so that the bug
> should not be related to camera.
> Kernel is vanilla 2.4.18.
> 
> Any tips ?

I don't know the specifics of that driver, sorry, but I'd recommend
asking this on the linux-usb-devel mailing list, as the ohci driver
authors are there.  I don't think they read lkml much.

thanks,

greg k-h
