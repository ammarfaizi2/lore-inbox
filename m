Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265915AbUBJOwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 09:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265924AbUBJOwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 09:52:00 -0500
Received: from lists.us.dell.com ([143.166.224.162]:15247 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S265915AbUBJOv4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 09:51:56 -0500
Date: Tue, 10 Feb 2004 08:51:20 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Thomas Horsten <thomas@horsten.com>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: ATARAID userspace configuration tool
Message-ID: <20040210085120.A22710@lists.us.dell.com>
References: <Pine.LNX.4.40.0402101405190.25784-100000@jehova.dsm.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.40.0402101405190.25784-100000@jehova.dsm.dk>; from thomas@horsten.com on Tue, Feb 10, 2004 at 02:18:15PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 02:18:15PM +0000, Thomas Horsten wrote:
> - After I have used the DM (and possible MD for some RAID types) to map
> the ataraid devices, is there a way to remove the partitions from the
> underlying disks from the kernel?
> Detecting the partition table in userspace would fix this, but it's not
> planned before 2.7 and I don't think it is safe to leave the false
> partitions exposed.

partx, part of util-linux, can do this in userspace today.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
