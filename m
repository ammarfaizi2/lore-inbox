Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWARLYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWARLYf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 06:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbWARLYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 06:24:35 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:16346 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1030225AbWARLYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 06:24:35 -0500
Date: Wed, 18 Jan 2006 12:24:31 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Michael Loftis <mloftis@wgops.com>, linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
Message-ID: <20060118112431.GA11868@harddisk-recovery.nl>
References: <E1EywcM-0004Oz-IE@laurel.muq.org> <B34375EBA93D2866BECF5995@d216-220-25-20.dynip.modwest.com> <D62A7AD5-0954-4FA9-8E20-0E026A3E765A@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D62A7AD5-0954-4FA9-8E20-0E026A3E765A@mac.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 07:12:57PM -0500, Kyle Moffett wrote:
> The most reliable RAID-5 you can build is a 3-drive system.  For each  
> byte of data, you have a half-byte of parity, meaning that half the  
> data-space (not including the parity) can fail without data loss.   
> I'm ignoring the issue of rotating parity drive for simplicity, but  
> that only affects performance, not the algorithm.  If you want any  
> kind of _real_ reliability and speed, you should buy a couple good  
> hardware RAID-5 units and mirror them in software.

Actually, the most reliable RAID-5 is a 2 drive system, where you have
a full byte of reduncancy for each byte of data. Two drive RAID-5
systems are usually called RAID-1, but if you write out the formulas it
becomes clear that RAID-1 is just a special case of RAID-5.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com
