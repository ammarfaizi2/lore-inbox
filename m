Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422942AbWBBFao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422942AbWBBFao (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 00:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422939AbWBBFao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 00:30:44 -0500
Received: from xenotime.net ([66.160.160.81]:5516 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422942AbWBBFan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 00:30:43 -0500
Date: Wed, 1 Feb 2006 21:31:09 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1 kernel init oops
Message-Id: <20060201213109.33bf49d8.rdunlap@xenotime.net>
In-Reply-To: <20060130044436.GA13244@kroah.com>
References: <20060128171841.6f989958.rdunlap@xenotime.net>
	<20060128175511.35e39233.rdunlap@xenotime.net>
	<20060129190029.GB7168@kroah.com>
	<20060129111934.53710b03.rdunlap@xenotime.net>
	<20060129201923.GB6972@kroah.com>
	<20060129130812.011d8bf3.rdunlap@xenotime.net>
	<20060129150737.6f911430.rdunlap@xenotime.net>
	<20060129165732.03446fc3.rdunlap@xenotime.net>
	<20060130044436.GA13244@kroah.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2006 20:44:36 -0800 Greg KH wrote:

> On Sun, Jan 29, 2006 at 04:57:32PM -0800, Randy.Dunlap wrote:
> > furthermore, this happens on 2.6.16-rc1 and 2.6.16-rc1-git4,
> > but <platform_notify> is not at the same memory address in
> > my builds, so it smells more like a bad ptr reference
> > somewhere than like bad memory IMO.
> 
> Hm, can you do a git bisect from 2.6.15 to 2.6.16-rc1 to see if you can
> find this?

follow-up:  for now I guess I'll blame the oopsen that I was seeing
on a bad compiler or just karma.  I don't have proof except that
I installed a new distro + gcc and no longer can cause/create the
problems.  (was using gcc 3.4.3 from Mandriva 2005)

thanks,
---
~Randy
