Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135924AbRDZU7H>; Thu, 26 Apr 2001 16:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135931AbRDZU6n>; Thu, 26 Apr 2001 16:58:43 -0400
Received: from zeus.kernel.org ([209.10.41.242]:128 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135921AbRDZU6Q>;
	Thu, 26 Apr 2001 16:58:16 -0400
Date: Thu, 26 Apr 2001 22:39:50 +0200
From: Marko Kreen <marko@l-t.ee>
To: Bjorn Wesen <bjorn@sparta.lu.se>
Cc: Padraig Brady <padraig@antefacto.com>, linux-kernel@vger.kernel.org
Subject: Re: ramdisk/tmpfs/ramfs/memfs ?
Message-ID: <20010426223950.C3683@l-t.ee>
In-Reply-To: <3AE879AE.387D3B78@antefacto.com> <Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se>; from bjorn@sparta.lu.se on Thu, Apr 26, 2001 at 08:48:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 08:48:26PM +0200, Bjorn Wesen wrote:
> On Thu, 26 Apr 2001, Padraig Brady wrote:
> > 3. If I've no backing store (harddisk?) is there any advantage 
> >    of using tmpfs instead of ramfs? Also does tmpfs need a 
> >    backing store?
> 
> I don't know what tmpfs does actually, but if it is like you suggest (a
> ramfs that can be swapped out ?) then you don't need it obviously (since
> you don't have any swap).
> 
> ramfs simply inserts any files written into the kernels cache and tells it
> not to forget it. it can't get much more simple than that.
> 
> > 5. Can you set size limits on ramfs/tmpfs/memfs?
> 
> i don't think you can set a limit in the current ramfs implementation but
> it would not be particularly difficult to make it work I think

tmpfs is basically ramfs with limits.

-- 
marko

