Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUGVTRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUGVTRc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 15:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266913AbUGVTRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 15:17:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:60310 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261159AbUGVTRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 15:17:20 -0400
Date: Thu, 22 Jul 2004 15:12:55 -0400
From: Greg KH <greg@kroah.com>
To: "Giacomo A. Catenazzi" <cate@pixelized.ch>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@fs.tum.de>,
       corbet@lwn.net, bgerst@didntduck.org, linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-ID: <20040722191255.GA28813@kroah.com>
References: <40FEEEBC.7080104@quark.didntduck.org> <20040721231123.13423.qmail@lwn.net> <20040721235228.GZ14733@fs.tum.de> <20040722025539.5d35c4cb.akpm@osdl.org> <20040722070453.GA21907@kroah.com> <40FFA5BD.5000304@pixelized.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FFA5BD.5000304@pixelized.ch>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 01:32:13PM +0200, Giacomo A. Catenazzi wrote:
> 
> The worse is the lack of stable name of devices, in udev too.
> I.e. microcode loader (Intel CPU) needs a device, which was so
> named (last time I controlled):

When was the last time you _used_ the microcode device?

Yeah, there are still a small number of drivers that are not in sysfs,
so udev doesn't know about them, but right now I'm guessing we cover
about 95%.  I'm waiting for someone else to fix up the rest, if they
really have one of those odd devices :)

thanks,

greg k-h
