Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbTLWTYd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 14:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTLWTYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 14:24:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23186 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262546AbTLWTYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 14:24:30 -0500
Date: Tue, 23 Dec 2003 19:24:27 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Rob Love <rml@ximian.com>
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
Message-ID: <20031223192427.GC4176@parcelfarce.linux.theplanet.co.uk>
References: <20031223002126.GA4805@kroah.com> <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com> <20031223131523.B6864@infradead.org> <20031223180127.GA14282@kroah.com> <20031223191634.A8914@infradead.org> <1072207183.6015.19.camel@fur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072207183.6015.19.camel@fur>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 02:19:43PM -0500, Rob Love wrote:
> On Tue, 2003-12-23 at 14:16, Christoph Hellwig wrote:
> 
> > What user-modifiable attributes?
> 
> See /proc/sys/kernel/random
> 
> Junk like that should be ripped from procfs and put in sysfs
> corresponding to its device file.

Junk like that is called "sysctl" and is a part of userland ABI.
