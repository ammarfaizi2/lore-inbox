Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316712AbSHBTRd>; Fri, 2 Aug 2002 15:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316789AbSHBTRd>; Fri, 2 Aug 2002 15:17:33 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:19212 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316712AbSHBTRc>;
	Fri, 2 Aug 2002 15:17:32 -0400
Date: Fri, 2 Aug 2002 12:19:07 -0700
From: Greg KH <greg@kroah.com>
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: network driver informations [general NIC, Wireless and e100]
Message-ID: <20020802191907.GA953@kroah.com>
References: <20020731212426.GA3342@schottelius.org> <3D492531.9030905@mandrakesoft.com> <20020801174252.GA58488@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020801174252.GA58488@compsoc.man.ac.uk>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 05 Jul 2002 18:11:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 06:42:52PM +0100, John Levon wrote:
> On Thu, Aug 01, 2002 at 08:10:25AM -0400, Jeff Garzik wrote:
> 
> > Al Viro has talked about, long term, making this information available 
> > through a filesystem.  When that happens, your request will have 
> > basically been implemented.
> 
> It would probably help if some of the basic code needed was wrapped in
> an even more "dumbed-down" API - most of the stuff in say pcihpfs is
> generically useful for this sort of configfs thing.

Hm, like perhaps 'driverfs'?  :)

That's where pcihpfs is going to go to, as soon as Pat makes a few more
changes to the API.

thanks,

greg k-h
