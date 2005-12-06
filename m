Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbVLFSB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVLFSB1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVLFSB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:01:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:42732 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964818AbVLFSB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:01:26 -0500
Date: Tue, 6 Dec 2005 09:59:19 -0800
From: Greg KH <greg@kroah.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051206175919.GI3084@kroah.com>
References: <20051203152339.GK31395@stusta.de> <20051203225020.GF25722@merlin.emma.line.org> <20051204002043.GA1879@kroah.com> <200512040446.32450.luke-jr@utopios.org> <20051204232205.GF8914@kroah.com> <4395A72E.6030006@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4395A72E.6030006@tmr.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 09:58:54AM -0500, Bill Davidsen wrote:
> 
> If a new udev config is needed with every new kernel, why isn't it in
> the kernel tarball? Is that what you mean by "broken distro
> configuration?" The info should be in /proc or /sys and not in an
> external config file, particularly if a different versions per-kernel is
> needed and people are trying new kernels and perhaps falling back to the
> old.

Every distro has different needs for its device naming and groups and
other intergration into the boot process.  To force all of them to unify
on one-grand-way-of-doing-things would just not work out at all.

Look at all of the variations in the udev tarball between the different
vendor configurations (we put them in there for other people to base
their distro off of, if they want to.)

So providing this config in the kernel will just not work, sorry.

greg k-h
