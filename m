Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbVLPTKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbVLPTKP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVLPTJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:09:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:151 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932379AbVLPTJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:09:44 -0500
Date: Fri, 16 Dec 2005 11:08:28 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 0/4] 4 patches for 2.6.15
Message-ID: <20051216190828.GA4594@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are 4 patches against your latest 2.6.15-git tree.  They fix the
following problems and should all go in for 2.6.15:
	- kernel oops in pci code for some thinkpads and other boxes.
	- kernel oops if pci express and pci express hotplug is built
	  into the kernel, instead of a module.
	- build breakage in a i2c driver.
	- memory barriers are needed for USB uhci driver in
	  suspend/resume path, as they were accidentally dropped in a
	  previous patch.

thanks,

greg k-h
