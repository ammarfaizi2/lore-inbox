Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVACNgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVACNgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 08:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVACNgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 08:36:15 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:47534 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261450AbVACNfs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 08:35:48 -0500
Date: Mon, 3 Jan 2005 15:35:42 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1
Message-ID: <20050103133542.GB17022@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103102535.GB17856@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103102535.GB17856@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Christoph Hellwig (hch@infradead.org) "Re: 2.6.10-mm1":
> > -ioctl-cleanup.patch
> > -unlocked_ioctl.patch
> > +ioctl-rework.patch
> > 
> >  New version of the dont-hold-BKL-across-ioctl patch.
> 
> For the native case the new naming is stupid.  The old ioctl_unlocked
> made perfect sense while ioctl_native doesn't - after all ->ioctl is
> native aswell.  Also this still has the useless inode * paramater in
> the method signature.

Regarding the inode* parameter, the change to remove it would be trivial,
though I personally dont care and I didnt see anyone else comment on that.
Anyone?


MST
