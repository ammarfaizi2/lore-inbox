Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263385AbTEMUZS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbTEMUZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:25:18 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:40939 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263385AbTEMUZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:25:15 -0400
Date: Tue, 13 May 2003 13:39:47 -0700
From: Greg KH <greg@kroah.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ehci-hcd.c needs to include <linux/bitops.h>
Message-ID: <20030513203947.GA11804@kroah.com>
References: <20030513155341.GB1609@malvern.uk.w2k.superh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513155341.GB1609@malvern.uk.w2k.superh.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 04:53:41PM +0100, Richard Curnow wrote:
> When I try to configure in EHCI support without this patch, I get
> generic_ffs undefined at link time.  (This is with 2.4.21-rc2 on our
> sh64 (SH-5) port).  Perhaps there are other ways to achieve this, but
> this worked for me.

Thanks, I've added this to my tree and will send it on.

greg k-h
