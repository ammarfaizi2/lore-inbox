Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268180AbUJCWm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268180AbUJCWm1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 18:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268184AbUJCWm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 18:42:27 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:37442 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268180AbUJCWmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 18:42:22 -0400
Message-ID: <9e473391041003154231bcccd8@mail.gmail.com>
Date: Sun, 3 Oct 2004 18:42:21 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Vladimir Dergachev <volodya@mindspring.com>
Subject: Re: Merging DRM and fbdev
Cc: Dave Airlie <airlied@linux.ie>, dri-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410031636320.18135@node2.an-vo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104100220553c57624a@mail.gmail.com>
	 <Pine.LNX.4.58.0410030824280.2325@skynet>
	 <9e4733910410030833e8a6683@mail.gmail.com>
	 <Pine.LNX.4.61.0410031145560.17248@node2.an-vo.com>
	 <9e4733910410030924214dd3e3@mail.gmail.com>
	 <Pine.LNX.4.61.0410031254280.17448@node2.an-vo.com>
	 <9e473391041003105511b77003@mail.gmail.com>
	 <Pine.LNX.4.61.0410031636320.18135@node2.an-vo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there are device driver level interface defined for controlling
tuners? Or is this something that even needs to be done in a device
driver? With X on GL Xv will have to change form too.

On Sun, 3 Oct 2004 16:37:03 -0400 (EDT), Vladimir Dergachev
<volodya@mindspring.com> wrote:
> 
> 
> On Sun, 3 Oct 2004, Jon Smirl wrote:
> 
> > How is the tuner controlled? Is it a V4L insterface?
> 
> No, the tuner is controlled via Xserver Xv extension. No V4L interface is
> provided for tuner control.
> 
>                        best
> 
>                           Vladimir Dergachev
> 
> 
> 
> >
> >
> > On Sun, 3 Oct 2004 12:59:38 -0400 (EDT), Vladimir Dergachev
> > <volodya@mindspring.com> wrote:
> >> Jon, this is a common misconception - GATOS km module *does* provide a v4l
> >> interface.
> >>
> >> What is different is that the device configuration (like setting the tuner
> >> or encoding) is done by Xserver.
> >>
> >> All km does is check whether the card can supply a v4l stream and, if so,
> >> it provides it. This is little different from a webcam driver, especially
> >> if a webcam has its own on/off switch.
> >>
> >> The misconception arises from the fact that many v4l programs were only
> >> made to work with bt848 cards - they would *not* work with webcams any
> >> more than they would work with km.
> >>
> >>                                best
> >>
> >>                                  Vladimir Dergachev
> >>
> >>>
> >>> --
> >>> Jon Smirl
> >>> jonsmirl@gmail.com
> >>>
> >>>
> >>> -------------------------------------------------------
> >>> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> >>> Use IT products in your business? Tell us what you think of them. Give us
> >>> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
> >>> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> >>> --
> >>> _______________________________________________
> >>> Dri-devel mailing list
> >>> Dri-devel@lists.sourceforge.net
> >>> https://lists.sourceforge.net/lists/listinfo/dri-devel
> >>>
> >>
> >
> >
> >
> > --
> > Jon Smirl
> > jonsmirl@gmail.com
> >
> >
> > -------------------------------------------------------
> 
> 
> > This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> > Use IT products in your business? Tell us what you think of them. Give us
> > Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
> > http://productguide.itmanagersjournal.com/guidepromo.tmpl
> > --
> > _______________________________________________
> > Dri-devel mailing list
> > Dri-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/dri-devel
> >
> 



-- 
Jon Smirl
jonsmirl@gmail.com
