Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263265AbTEMGvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 02:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbTEMGve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 02:51:34 -0400
Received: from mail.zmailer.org ([62.240.94.4]:50666 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S263265AbTEMGvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 02:51:33 -0400
Date: Tue, 13 May 2003 10:04:17 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Andrew Morton <akpm@digeo.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [RFC][TTY] callout removal
Message-ID: <20030513070417.GJ24892@mea-ext.zmailer.org>
References: <20030513062332.GW10374@parcelfarce.linux.theplanet.co.uk> <20030512234415.11453a9c.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512234415.11453a9c.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 11:44:15PM -0700, Andrew Morton wrote:
...
> The current message is
> 	printk(KERN_WARNING "tty_io.c: "
> 		"process %d (%s) used obsolete /dev/%s - "
> 		"update software to use /dev/ttyS%d\n",
> and google("update software to use") == 201, spread across 1999-2001.

Even I have hit that, groaned, reconfigured things, and never
had trouble about it since.  Certainly didn't bother to write
to any list.

For certain people will encounter configurations that use very
old userspace things with new kernels.  After all, kernels are
easier to change than doing full re-install.

> Kill it.

I might instead add a bit of text:  "obsolete (since Year-Month) /dev/..."

/Matti Aarnio
