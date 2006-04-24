Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWDXT2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWDXT2Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWDXT2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:28:24 -0400
Received: from mail.suse.de ([195.135.220.2]:7113 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751165AbWDXT2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:28:24 -0400
Date: Mon, 24 Apr 2006 12:27:10 -0700
From: Greg KH <greg@kroah.com>
To: Gary Poppitz <poppitzg@iomega.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
Message-ID: <20060424192710.GB2505@kroah.com>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 01:16:26PM -0600, Gary Poppitz wrote:
> I have the task of porting an existing file system to Linux. This  
> code is in C++ and I have noticed that the Linux kernel has
> made use of C++ keywords and other things that make it incompatible.

We know they are "incompatible", why else would we allow "private" and
"struct class" in the kernel source if we some how expected it to work
with a C++ compiler?

Please see the lkml FAQ (linked to at the bottom of every lkml message)
for why this will not happen.

thanks,

greg k-h
