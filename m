Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTLWQIQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTLWQIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:08:16 -0500
Received: from peabody.ximian.com ([141.154.95.10]:13282 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261799AbTLWQHv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:07:51 -0500
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
From: Rob Love <rml@ximian.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <1072193516.3472.3.camel@fur>
References: <20031223002126.GA4805@kroah.com>
	 <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com>
	 <20031223131523.B6864@infradead.org>  <1072193516.3472.3.camel@fur>
Content-Type: text/plain
Message-Id: <1072195665.3472.13.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Tue, 23 Dec 2003 11:07:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-23 at 10:31, Rob Love wrote:

> Creating them via udev is the point.
> 
> Remember, the ultimate goal is to have udev in initramfs during early
> boot, and all of these vital devices will be created.
> 
> For udev to work as intended, all devices on the system must be
> represented in sysfs.

Oh, I think I get your point, now.

The devices actually do not need to be in sysfs, but we do need to
generate a hotplug event for them.

Nonetheless, I think it makes sense to also put them in sysfs.  I think
of sysfs has a "device tree" and not necessarily a "physical device
tree".

	Rob Love


