Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030609AbWF0Cy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030609AbWF0Cy1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 22:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933368AbWF0Cy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 22:54:26 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:33297 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S933343AbWF0Cy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 22:54:26 -0400
Date: Tue, 27 Jun 2006 12:55:15 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: 2.6.16.20/dm: can't create more then one snapshot of an lv
Message-ID: <20060627025515.GC2059@zip.com.au>
References: <20060619020040.GX2059@zip.com.au> <20060620142005.GA19254@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620142005.GA19254@agk.surrey.redhat.com>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 03:20:05PM +0100, Alasdair G Kergon wrote:
> On Mon, Jun 19, 2006 at 12:00:40PM +1000, CaT wrote:
> > I am attempting to create multiple snapshots of an lv ontop of a raid-5
> > software raid device and ext3+dir_index and resize_inode for the fs.
> > The kernel is a pure 64bit compile with Debian Sarge amd64 running on
> > top of it. The kernel is monolithic and I'm using lvm2 2.01.03-5 with
> > devmapper 1.01.
> > This works under 2.6.15.7. Under 2.6.16.20 I get this:
> 
> Update to lvm2 version 2.02.01 or later and device-mapper version 1.02.02
> or later.

Done. It's all good under 2.6.16.20. Thanks for that. I'm wondering
though. I checked the minimal requirements in the
/usr/src/linux/Documentation/Changes file but nothing is mentioned for
LVM there. Is this no longer the right place to check for what userspace
utils are required for certain kernel functionality? (or was it never the
right place?)

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
