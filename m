Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVBGURM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVBGURM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 15:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVBGUQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 15:16:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52403 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261283AbVBGUOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 15:14:02 -0500
Date: Mon, 7 Feb 2005 14:45:35 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Martins Krikis <mkrikis@yahoo.com>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
Message-ID: <20050207164535.GA5378@logos.cnet>
References: <87651hdoiv.fsf@yahoo.com> <420582C6.7060407@pobox.com> <1107682076.22680.58.camel@laptopd505.fenrus.org> <58cb370e050206044513eb7f89@mail.gmail.com> <42062BFE.7070907@pobox.com> <1107701373.22680.115.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107701373.22680.115.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 03:49:33PM +0100, Arjan van de Ven wrote:
> 
> > I consider it not a new feature, but a missing feature, since otherwise 
> > user data cannot be accessed in the RAID setups.
> 
> the same is true for all new hardware drivers and hardware support
> patches. And for new DRM (since new X may need it) and new .. and
> new ... where is the line?
> 
> for me a deep maintenance mode is about keeping existing stuff working;
> all new hw support and derivative hardware support (such as this) can be
> pointed at the new stable series... which has been out for quite some
> time now..

I personally dislike and discourage the addition of ANY new drivers to v2.4 at
this point, and I sincerely appreciate every argument against iswraid, but I 
have no problems with it because it looks like a valid special case since it 
allows users to access their ICH5/6 RAID partitions, as Jeff mentions.

Moreover the driver is going to die with v2.4 anyway, its not like any future 
compatibility problem is being introduced.

So I understand the argument against having it in the tree: the elegant way of doing
it is to use dmraid. 

But I dont buy it as an argument against merging it in a dying v2.4.x tree which 
purpose is to serve existing users. 

You are mistaken in arguing that "oh, since this driver can be merged, its likely that 
any v2.6 HW support/driver will be accepted in v2.4".

So, its up to Jeff, and he seems to be OK with it.
