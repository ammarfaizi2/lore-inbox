Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTLWPcH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 10:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbTLWPcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 10:32:06 -0500
Received: from peabody.ximian.com ([141.154.95.10]:57825 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261506AbTLWPcD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 10:32:03 -0500
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
From: Rob Love <rml@ximian.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <20031223131523.B6864@infradead.org>
References: <20031223002126.GA4805@kroah.com>
	 <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com>
	 <20031223131523.B6864@infradead.org>
Content-Type: text/plain
Message-Id: <1072193516.3472.3.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Tue, 23 Dec 2003 10:31:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-23 at 08:15, Christoph Hellwig wrote:

> This is pointless.  The original point of sysfs and co was to present the
> physical device tree, where these devices absolutely fit into.  Why are
> you doing this at all?  Creating thse through udev doesn't make sense as
> they need to be present anyway..

Creating them via udev is the point.

Remember, the ultimate goal is to have udev in initramfs during early
boot, and all of these vital devices will be created.

For udev to work as intended, all devices on the system must be
represented in sysfs.

	Rob Love


