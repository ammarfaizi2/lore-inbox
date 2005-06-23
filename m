Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263030AbVFWSnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbVFWSnv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 14:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbVFWSje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 14:39:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22441 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263031AbVFWSgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 14:36:51 -0400
Date: Thu, 23 Jun 2005 11:32:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, pavel@suse.cz, ak@muc.de,
       hch@lst.de, Dave Airlie <airlied@linux.ie>
Subject: Re: [PATCH] Add removal schedule of
 register_serial/unregister_serial to appropriate file
Message-Id: <20050623113254.2675ffc6.akpm@osdl.org>
In-Reply-To: <20050623140316.GH3749@stusta.de>
References: <20050623142335.A5564@flint.arm.linux.org.uk>
	<20050623140316.GH3749@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> On Thu, Jun 23, 2005 at 02:23:35PM +0100, Russell King wrote:
> >...
> > However, wouldn't it be a good idea if this file was ordered by "when" ?
> > A quick scan of the file reveals a couple of overdue/forgotten items
> > (maybe they happened but the entry in the file got missed?):
> >...
> > What:   register_ioctl32_conversion() / unregister_ioctl32_conversion()
> > When:   April 2005
> >...
> 
> The removal (including the removal of the feature-removal-schedule.txt 
> entry) is already in -mm.

Actually it has been temporarily removed because it has a dependency on
update-drm-ioctl-compatibility-to-new-world-order.patch which has a
dependency on David's DRM tree and I don't know how to get David's DRM tree
any more.  Hint.

