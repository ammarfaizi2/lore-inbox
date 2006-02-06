Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWBFESL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWBFESL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 23:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWBFESL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 23:18:11 -0500
Received: from xenotime.net ([66.160.160.81]:5763 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750955AbWBFESL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 23:18:11 -0500
Date: Sun, 5 Feb 2006 20:18:44 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit -
 Resubmit
Message-Id: <20060205201844.447efd20.rdunlap@xenotime.net>
In-Reply-To: <43E3BDDD.6000402@gmail.com>
References: <43E3BDDD.6000402@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Feb 2006 22:32:29 +0200 Alon Bar-Lev wrote:

> 
> Extending the kernel parameters to a size of 1024 on boot
> protocol >=2.02 for i386 and x86_64 architectures.
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
> 
> ---
> 
> Hello,
> 
> This patch was submitted a long ago, but did not find its 
> way into the kernel, but was not rejected as well.
> 
> Current implementation allows the kernel to receive up to 
> 255 characters from the bootloader.
> 
> In current environment, the command-line is used in order to
> specify many values, including suspend/resume, module
> arguments, splash, initramfs and more.
> 
> 255 characters are not enough anymore.
> 
> Please consider to merge.

Please explain this comment and why it is being added:

+	The kernel command line *must* be 256 bytes including the
+	final null.
+
 
thanks,
---
~Randy
