Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267285AbTABVgB>; Thu, 2 Jan 2003 16:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267266AbTABVfK>; Thu, 2 Jan 2003 16:35:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40097 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267254AbTABVeL>;
	Thu, 2 Jan 2003 16:34:11 -0500
Date: Thu, 2 Jan 2003 22:42:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Byron Albert <balbert@jupitermedia.com>, linux-kernel@vger.kernel.org
Subject: Re: cciss driver
Message-ID: <20030102214215.GJ13332@suse.de>
References: <3E147CAD.5050901@jupitermedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E147CAD.5050901@jupitermedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02 2003, Byron Albert wrote:
> Hello all,
> 
>  I have noticed that there have been alot of changes to the cciss 
> driver in the last few revs of the 2.4 kernel a diff of 2.4.18 and 
> 2.4.20 show  this (2500 lines in a patch). But the driver version has 
> not changed.  I am trying to figure out how the version in the kernel 
> relates to the version on hp's web site.  On there website they have a 
> 2.4.34 version that has patches witch will patch the kernel that comes 
> with redhat 8.0 witch doesn't help me much because that kernel is an rc 
> kernel with about 100 other patches 3 of witch touch this driver.
> 
> Can any one be of some help. I am going to be deploying alot of 
> machines with this card in the next few months and would like some of 
> the fetures the newer driver gets me.

You probably just want to grab either 2.4.21-pre2 or extract the cciss
changes from that patch - that'll bring the driver up to 2.4.42, which,
as far as I'm told, is the latest and (hopefully) greatest.

-- 
Jens Axboe

