Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWFTOUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWFTOUR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWFTOUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:20:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36254 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751047AbWFTOUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:20:15 -0400
Date: Tue, 20 Jun 2006 15:20:05 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: 2.6.16.20/dm: can't create more then one snapshot of an lv
Message-ID: <20060620142005.GA19254@agk.surrey.redhat.com>
Mail-Followup-To: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com
References: <20060619020040.GX2059@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619020040.GX2059@zip.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 12:00:40PM +1000, CaT wrote:
> I am attempting to create multiple snapshots of an lv ontop of a raid-5
> software raid device and ext3+dir_index and resize_inode for the fs.
> The kernel is a pure 64bit compile with Debian Sarge amd64 running on
> top of it. The kernel is monolithic and I'm using lvm2 2.01.03-5 with
> devmapper 1.01.
> This works under 2.6.15.7. Under 2.6.16.20 I get this:

Update to lvm2 version 2.02.01 or later and device-mapper version 1.02.02
or later.

Alasdair
-- 
agk@redhat.com
