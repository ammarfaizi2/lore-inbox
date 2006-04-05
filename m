Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWDESqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWDESqX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 14:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWDESqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 14:46:23 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:47579
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751329AbWDESqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 14:46:22 -0400
Date: Wed, 5 Apr 2006 11:45:32 -0700
From: Greg KH <greg@kroah.com>
To: Beber <beber.lkml@gmail.com>
Cc: Bertrand Jacquin <beber@gna.org>, gregkh@suse.de,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: [stable] Re: [PATCH] isd200: limit to BLK_DEV_IDE
Message-ID: <20060405184532.GA2577@kroah.com>
References: <20060328075629.GA8083@kroah.com> <4615f4910603301146x5496ccaai17bf5f4636c91c45@mail.gmail.com> <Pine.LNX.4.58.0603301431560.26598@shark.he.net> <20060331095236.72e5ab52.beber@gna.org> <4615f4910604050635v5af3dbc6w17849adb2fd64593@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4615f4910604050635v5af3dbc6w17849adb2fd64593@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 03:35:38PM +0200, Beber wrote:
> On 3/31/06, Bertrand Jacquin <beber@gna.org> wrote:
> > Le Thu, 30 Mar 2006 14:35:26 -0800 (PST), "Randy.Dunlap" <rdunlap@xenotime.net> m'a avou?:
> >
> > > On Thu, 30 Mar 2006, Beber wrote:
> > >
> > > > On 3/28/06, Greg KH <gregkh@suse.de> wrote:
> > > > > We (the -stable team) are announcing the release of the 2.6.16.1 kernel.
> > > >
> > > > I still get this error :
> > > >
> > > > # make
> > > ...
> > > > drivers/built-in.o: In function `isd200_Initialization':
> > > > : undefined reference to `ide_fix_driveid'
> > > > make: *** [.tmp_vmlinux1] Error 1
> > >
> > > Was this reported earlier?
> >
> > Yes, it was, but ignored, so I repost it ;)
> >
> > > Please test the patch below.
> > > It works for me with your config and various others.
> >
> > It work here too.
> > Thanks
> 
> I look on last GIT history and didn't find this applyed upstream. Will it be ?

No one has forwarded it to the stable group, so it's a bit hard to apply
it to the tree if that doesn't happen :)

thanks,

greg k-h
