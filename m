Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261304AbSJDFTi>; Fri, 4 Oct 2002 01:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261399AbSJDFTi>; Fri, 4 Oct 2002 01:19:38 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:10510 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261304AbSJDFTh>;
	Fri, 4 Oct 2002 01:19:37 -0400
Date: Thu, 3 Oct 2002 22:22:18 -0700
From: Greg KH <greg@kroah.com>
To: John Tyner <jtyner@cs.ucr.edu>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org,
       kraxel@bytesex.org
Subject: Re: Vicam/3com homeconnect usb camera driver
Message-ID: <20021004052218.GA4105@kroah.com>
References: <Pine.LNX.4.30.0210032047510.15999-400000@hill.cs.ucr.edu> <20021004045051.GB3556@kroah.com> <000401c26b63$9ac9dc90$0a00a8c0@refresco>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000401c26b63$9ac9dc90$0a00a8c0@refresco>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 10:05:05PM -0700, John Tyner wrote:
> > If you send me a patch for 2.5, I'd be glad to add it to the tree.
> > Right now, I'm not accepting USB drivers that don't show up in 2.5
> > first.
> 
> I'll get to work.

Great!

> > Other than that, the code looks nice.  Did you look at how the usb video
> > drivers do their memory management in 2.4.20-pre like I mentioned
> > before?
> 
> I did. The ov511 as well as the bttv and cpia drivers still use the
> rvmalloc/rvfree methods. They are minor'ly updated from the version I was
> using, and I've already incorporated those changes to the driver submitted
> in my previous post.

Ah, good, I just wanted to make sure, as I know there were some changes
there.

thanks,

greg k-h
