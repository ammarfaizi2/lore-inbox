Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSDRLxW>; Thu, 18 Apr 2002 07:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314327AbSDRLxV>; Thu, 18 Apr 2002 07:53:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59922 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314325AbSDRLxU>;
	Thu, 18 Apr 2002 07:53:20 -0400
Date: Thu, 18 Apr 2002 13:53:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.9: ide: unexpected interrupt 1 12
Message-ID: <20020418115315.GA2492@suse.de>
In-Reply-To: <200204180743.45666.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18 2002, Ed Tomlinson wrote:
> Hi,
> 
> I pulled the latest 2.5 souce, checked with revtool and found the last
> changeset converted it to 2.5.9, so I decided to try it out here.  It
> almost works.  During boot I get hundreds of 'ide: unexpected
> interrupts 1 12'.  This is after the kernel reconizes that I have a
> promize 20267 on int 12.  Is this one known?  If not what else should
> I gather?.

Just a debug print, apparently gone haywire on your system. Just comment
out the "ide: unexpected interrupt [...]" line in ide.c:ide_intr() for
now.

-- 
Jens Axboe

