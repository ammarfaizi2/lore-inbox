Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbTEKO0T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 10:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbTEKO0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 10:26:19 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:32521 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261515AbTEKO0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 10:26:18 -0400
Date: Sun, 11 May 2003 14:51:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Jones <davej@codemonkey.org.uk>, Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.69-dj1: agp_init shouldn't be static
Message-ID: <20030511145148.A20017@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@codemonkey.org.uk>, Adrian Bunk <bunk@fs.tum.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030510145653.GA26216@suse.de> <20030511122934.GH1107@fs.tum.de> <20030511132120.GA8834@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030511132120.GA8834@suse.de>; from davej@codemonkey.org.uk on Sun, May 11, 2003 at 02:21:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 02:21:20PM +0100, Dave Jones wrote:
> duhh, the 810 framebuffer needs it early. I forgot about that.
> Will apply patch, and add a comment. Thanks.

no, it doesn't need the agp banner printk early :)  Fix i810fb instead.

