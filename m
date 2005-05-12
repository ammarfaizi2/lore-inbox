Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVELWdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVELWdQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 18:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVELWdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 18:33:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59657 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262159AbVELWak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 18:30:40 -0400
Date: Fri, 13 May 2005 00:30:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/: remove unneeded EXPORT_SYMBOL's
Message-ID: <20050512223035.GF3603@stusta.de>
References: <20050417195706.GD3625@stusta.de> <20050419191328.GJ1111@conscoop.ottawa.on.ca> <1113939827.6277.86.camel@laptopd505.fenrus.org> <42657F7C.8060305@s5r6.in-berlin.de> <1113981989.6238.30.camel@laptopd505.fenrus.org> <426683E9.4080708@s5r6.in-berlin.de> <1114029144.5085.20.camel@kino.dennedy.org> <4270001F.8020504@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4270001F.8020504@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 11:11:59PM +0200, Stefan Richter wrote:
> Dan Dennedy wrote on 2005-04-20:
> >There are technical
> >merits for removal of the external symbols that I accept. I also accept
> >that we have no way of maintaining any sort of stable subsystem for
> >external projects we are not aware of or who are not communicating with
> >us about their requirements (it goes beyond just a stable interface).
> ...
> >I vote to remove external symbols not used by the Linux1394.org modules
> >or the module at http://sourceforge.net/projects/video-2-1394/
> 
> Nobody else posted specific requirements so far. So let's clean up the 
> API. How about this:
>  - Determine a date or event at which unused symbols and functions will
>    vanish. ("Unused": Not used by the mainline drivers and video-2-1394
>    or any other project of similar scope of which the linux1394
>    maintainers are informed soon enough.)

OK.

>  - Add an according entry to Documentation/feature-removal-schedule.txt.

OK.

>  - Add warning comments next to obsolete EXPORT_SYMBOLs. Add warning
>    printks to obsolete functions? (If there are any.)

OK.

> Are there proposals for a date? How about end of June?

OK (now it's perhaps beginning of Juli).


Is this OK for everyone?
If yes, I can prepare a patch.


> Stefan Richter

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

