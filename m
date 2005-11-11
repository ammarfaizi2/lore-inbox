Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbVKKJdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbVKKJdI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 04:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVKKJdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 04:33:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15038 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932315AbVKKJdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 04:33:06 -0500
Date: Fri, 11 Nov 2005 01:31:42 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: greg@kroah.com, stern@rowland.harvard.edu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       mdharm-usb@one-eyed-alien.net, reuben-lkml@reub.net, zaitcev@redhat.com
Subject: Re: [-mm patch] USB_LIBUSUAL shouldn't be user-visible
Message-Id: <20051111013142.269b1db5.zaitcev@redhat.com>
In-Reply-To: <20051111020938.GJ5376@stusta.de>
References: <20051107215226.GA25104@kroah.com>
	<Pine.LNX.4.44L0.0511071725220.5165-100000@iolanthe.rowland.org>
	<20051107222840.GB26417@kroah.com>
	<20051108004716.GJ3847@stusta.de>
	<20051109222808.GG9182@kroah.com>
	<20051109224117.337690bf.zaitcev@redhat.com>
	<20051110105648.GC5376@stusta.de>
	<20051110234644.GA6430@kroah.com>
	<20051111020938.GJ5376@stusta.de>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005 03:09:38 +0100, Adrian Bunk <bunk@stusta.de> wrote:

> What about my second suggestion to always use libusual in the two 
> drivers instead of having two code paths in each of them?

I don't see how you would be able to mandate libusual, since it adds
(a small amount of) bloat. I foresee some distributions building without
it for years. Debian is likely to take such course.

We certainly can apply such a patch and tell all complainers to suck
it up, but I am not sure if that would be embraced by distro developers.
I do not want to risk anything that may derail acceptance into
Linus' tree.

-- Pete
