Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316985AbSEWS6e>; Thu, 23 May 2002 14:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316986AbSEWS6d>; Thu, 23 May 2002 14:58:33 -0400
Received: from [195.63.194.11] ([195.63.194.11]:21775 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316985AbSEWS6c>; Thu, 23 May 2002 14:58:32 -0400
Message-ID: <3CED2CF5.5050202@evision-ventures.com>
Date: Thu, 23 May 2002 19:55:01 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: gowdy@slac.stanford.edu, Andre Bonin <kernel@bonin.ca>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] Re: What to do with all of the USB UHCI drivers
 in the kernel?
In-Reply-To: <Pine.LNX.4.44.0205230746500.1824-100000@router-273.sgowdy.org> <3CECFBEE.9010802@evision-ventures.com> <20020523160410.GC11153@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Greg KH napisa?:

> Anyway, here's the documentation that you need:
> 	The module usb-ohci is now gone.  Use ohci-hcd instead.
> 
> The people with UHCI controllers have a big more documentation to read:
> 	The module uhci is now gone.  If you used this module, use
> 	uhci-hcd instead.  The module usb-uhci is now gone.  If you used
> 	this module, use usb-uhci-hcd instead.  If you have a preference
> 	over which UHCI module works better for you, please email
> 	greg@kroah.com your comments, as one of these modules will be
> 	going away in the near future.

Thank's that is explaining it.
But I would have loved it if it appeared with + in front in
the patch somewhere. That's the only true problem I had.
OK?

BTW.> usb-ohci seems to be a more reasonable name, since
it tells me directly - hey buddy I'm USB the -hcd doen't
tell me anything in addition and is entierly redundant, or
is there a ohci.o module there?

And why not just doing the following.

1. Rename usb-ohci to usb-ohci-old

2. Rename ohci-hcd to usb-ohci

Much less grief and guessing what happens :-).

Just a suggestion.

