Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVBGAmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVBGAmX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 19:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVBGAmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 19:42:23 -0500
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:55693 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S261328AbVBGAmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 19:42:20 -0500
Date: Mon, 7 Feb 2005 01:42:18 +0100
From: =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: msdos/vfat defaults are annoying
Message-ID: <20050207004218.GA12541@ojjektum.uhulinux.hu>
References: <4205AC37.3030301@comcast.net> <20050206070659.GA28596@infradead.org> <20050206232108.GA31813@ojjektum.uhulinux.hu> <20050207003610.GP8859@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207003610.GP8859@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 12:36:10AM +0000, Al Viro wrote:
> On Mon, Feb 07, 2005 at 12:21:08AM +0100, Pozsar Balazs wrote:
> > On Sun, Feb 06, 2005 at 07:06:59AM +0000, Christoph Hellwig wrote:
> > > On Sun, Feb 06, 2005 at 12:33:43AM -0500, John Richard Moser wrote:
> > > > I dunno.  I can never understand the innards of the kernel devs' minds.
> > > 
> > > filesystem detection isn't handled at the kerne level.
> > 
> > Yeah, but the link order could be changed... Patch inlined.
> 
> And just what does the link order (or changes thereof) have to do with that?

IIRC currently if both msdos and vfat are compiled in (not modules), and 
you try to mount a vfat filesystem without explicitly specifying the fs 
type, it will be mounted with the msdos type. With the, it will mounted 
vfat.


-- 
pozsy
