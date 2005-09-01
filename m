Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbVIAUW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbVIAUW6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbVIAUW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:22:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45537 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030368AbVIAUW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:22:57 -0400
Date: Thu, 1 Sep 2005 13:21:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: teigland@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-Id: <20050901132104.2d643ccd.akpm@osdl.org>
In-Reply-To: <1125586158.15768.42.camel@localhost.localdomain>
References: <20050901104620.GA22482@redhat.com>
	<20050901035939.435768f3.akpm@osdl.org>
	<1125586158.15768.42.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Iau, 2005-09-01 at 03:59 -0700, Andrew Morton wrote:
> > - Why the kernel needs two clustered fileystems
> 
> So delete reiserfs4, FAT, VFAT, ext2, and all the other "junk". 

Well, we did delete intermezzo.

I was looking for technical reasons, please.

> > - Why GFS is better than OCFS2, or has functionality which OCFS2 cannot
> >   possibly gain (or vice versa)
> > 
> > - Relative merits of the two offerings
> 
> You missed the important one - people actively use it and have been for
> some years. Same reason with have NTFS, HPFS, and all the others. On
> that alone it makes sense to include.

Again, that's not a technical reason.  It's _a_ reason, sure.  But what are
the technical reasons for merging gfs[2], ocfs2, both or neither?

If one can be grown to encompass the capabilities of the other then we're
left with a bunch of legacy code and wasted effort.

I'm not saying it's wrong.  But I'd like to hear the proponents explain why
it's right, please.
