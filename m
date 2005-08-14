Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbVHNDWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVHNDWD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 23:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVHNDWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 23:22:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15797 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932409AbVHNDWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 23:22:01 -0400
Date: Sat, 13 Aug 2005 20:20:46 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Bodo Eggert <7eggert@gmx.de>
Cc: 7eggert@gmx.de, harvested.in.lkml@7eggert.dyndns.org,
       vonbrand@inf.utfsm.cl, linux-kernel@vger.kernel.org
Subject: Re: Problem with usb-storage and /dev/sd?
Message-Id: <20050813202046.50c41405.zaitcev@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0508131149070.2192@be1.lrz>
References: <4pzyn-10f-33@gated-at.bofh.it>
	<4AubX-4w6-9@gated-at.bofh.it>
	<E1E3X6P-0000cN-BB@be1.lrz>
	<20050812103832.28ff17a0.zaitcev@redhat.com>
	<Pine.LNX.4.58.0508131149070.2192@be1.lrz>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Aug 2005 12:06:16 +0200 (CEST), Bodo Eggert <7eggert@gmx.de> wrote:
> On Fri, 12 Aug 2005, Pete Zaitcev wrote:
> > On Fri, 12 Aug 2005 12:49:28 +0200, Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org> wrote:
> > 
> > > Which label will a random USB stick have?
> > 
> > GUID, I presume.
> 
> A global unique ID won't work out to make all USB mass storage devices
> appear under a common mountpoint, especially if it is recreated while
> "formating" it.

That is correct, but not what Dervish wanted. He wanted to mount them
on separate pre-assigned mount points. If you want all of them to mount
on the same place, just use /dev/sda1!

-- Pete
