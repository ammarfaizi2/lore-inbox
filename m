Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267367AbUIFAbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267367AbUIFAbb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 20:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUIFAbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 20:31:31 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:18920 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267367AbUIFAb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 20:31:29 -0400
Message-ID: <9e4733910409051731161984ee@mail.gmail.com>
Date: Sun, 5 Sep 2004 20:31:27 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: multi-domain PCI and sysfs
Cc: Matthew Wilcox <willy@debian.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200409051706.50455.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910409041300139dabe0@mail.gmail.com>
	 <200409041603.56324.jbarnes@engr.sgi.com>
	 <20040905230425.GU642@parcelfarce.linux.theplanet.co.uk>
	 <200409051706.50455.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Sep 2004 17:06:50 -0700, Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> /sys/devices/pciDDDD/BB/SS.F/foo
> rather than the current
> /sys/devices/pciDDDD:BB/DDDD:BB:SS.F/foo
> 

/sys/devices/pciDDDD/BB/DDDD:BB:SS.F/foo

Would be better. You want the fully qualified location on the device node.


-- 
Jon Smirl
jonsmirl@gmail.com
