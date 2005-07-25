Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVGYUHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVGYUHB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 16:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVGYUEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 16:04:20 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:62288 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S261499AbVGYUDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 16:03:31 -0400
Date: Mon, 25 Jul 2005 22:03:30 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Andreas Baer <lnx1@gmx.net>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       pmarques@grupopie.com
Subject: Re: Problem with Asus P4C800-DX and P4 -Northwood-
Message-ID: <20050725200330.GA20811@harddisk-recovery.nl>
References: <42E4373D.1070607@gmx.net> <20050725051236.GS8907@alpha.home.local> <42E4E4B0.6050904@gmx.net> <20050725152425.GA24568@alpha.home.local> <42E542D5.3080905@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E542D5.3080905@gmx.net>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 09:51:49PM +0200, Andreas Baer wrote:
> 
> Willy Tarreau wrote:
> >On Mon, Jul 25, 2005 at 03:10:08PM +0200, Andreas Baer wrote:
> >>Here I have
> >>
> >>        /dev/hda:  26.91 MB/sec
> >>        /dev/hda1: 26.90 MB/sec    (Windows FAT32)
> >>        /dev/hda7: 17.89 MB/sec    (Linux EXT3)
> >>
> >>Could you give me a reason how this is possible?
> >
> >
> >a reason for what ? the fact that the notebook performs faster than the
> >desktop while slower on I/O ?
> 
> No, a reason why the partition with Linux (ReiserFS or Ext3) is always 
> slower
> than the Windows partition?

Easy: Drives don't have the same speed on all tracks. The platters are
built-up from zones with different recording densities: zones near the
center of the platters have a lower recording density and hence a lower
datarate (less bits/second pass under the head). Zones at the outer
diameter have a higher recording density and a higher datarate.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.nl -- 0800 220 20 20 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com
