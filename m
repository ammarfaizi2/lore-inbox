Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbVKHSuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbVKHSuo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbVKHSun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:50:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54034 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030307AbVKHSum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:50:42 -0500
Date: Tue, 8 Nov 2005 19:50:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove USB_AUDIO and USB_MIDI drivers
Message-ID: <20051108185041.GD3847@stusta.de>
References: <20051108181239.GB3847@stusta.de> <20051108184638.GA15939@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108184638.GA15939@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 10:46:38AM -0800, Greg KH wrote:
> On Tue, Nov 08, 2005 at 07:12:39PM +0100, Adrian Bunk wrote:
> > Since I've gotten exactly zero negative feedback, this patch removes the 
> > obsolete USB_AUDIO and USB_MIDI drivers.
> > 
> > It also makes the global function usb_get_string() static since this 
> > function no longer has any external user.
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > ---
> > 
> >  drivers/usb/Makefile         |    2 
> >  drivers/usb/class/Kconfig    |   47 
> >  drivers/usb/class/Makefile   |    2 
> >  drivers/usb/class/audio.c    | 3870 -----------------------------------
> >  drivers/usb/class/audio.h    |  110 
> >  drivers/usb/class/usb-midi.c | 2154 -------------------
> >  drivers/usb/class/usb-midi.h |  164 -
> >  drivers/usb/core/message.c   |    5 
> >  include/linux/usb.h          |    2 
> >  9 files changed, 2 insertions(+), 6354 deletions(-)
> > 
> > Due to it's size, the patch is attached gzip'ed.
> 
> Ugh, care to send it not gziped?  I can handle large patches...

Sure, I'll send it with the Cc' to linux-kernel removed.

> And please split the get_string one out into a separate patch.

OK.

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

