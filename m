Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269524AbRHCRte>; Fri, 3 Aug 2001 13:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269527AbRHCRtY>; Fri, 3 Aug 2001 13:49:24 -0400
Received: from marine.sonic.net ([208.201.224.37]:50468 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S269524AbRHCRtM>;
	Fri, 3 Aug 2001 13:49:12 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Fri, 3 Aug 2001 10:49:20 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Message-ID: <20010803104920.I437@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01080315090600.01827@starship>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 03:09:06PM +0200, Daniel Phillips wrote:
> On Friday 03 August 2001 05:13, Alexander Viro wrote:
> > On Fri, 3 Aug 2001, Daniel Phillips wrote:
> > > There is only one chain of directories from the fd's dentry up to
> > > the root, that's the one to sync.
> >
> > You forgot ".. at any given moment". IOW, operation you propose is
> > inherently racy. You want to do that - you do that in userland.
> 
> Are you saying that there may not be a ".." some of the time?  Or just 
> that it may spontaneously be relinked?  If it does spontaneously change 
> it doesn't matter, you have still made sure there is access by at least 
> one path.


I read the ".." as a typo for "..."  As in Al was suggesting the sentence
should read "There is only one chain of directories at any given moment
from the fd's dentry up to the root...."

At least, that was my reading on it.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
