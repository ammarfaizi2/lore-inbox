Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUDMAl2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 20:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbUDMAl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 20:41:28 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:27183 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263166AbUDMAlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 20:41:21 -0400
Date: Tue, 13 Apr 2004 10:41:10 +1000
From: Nathan Scott <nathans@sgi.com>
To: Daniel Brahneborg <daniel.brahneborg@infoflexconnect.se>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: block -> name ?
Message-ID: <20040413104110.A176038@wobbly.melbourne.sgi.com>
References: <20040412084148.A11645@infoflexconnect.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040412084148.A11645@infoflexconnect.se>; from daniel.brahneborg@infoflexconnect.se on Mon, Apr 12, 2004 at 08:41:48AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 08:41:48AM +0200, Daniel Brahneborg wrote:
> Hi,
> 
> Recently my computer running Linux kernel 2.4.25 started
> halting all of a sudden, and running badblocks a couple
> of times showed that it was caused by reading around block
> 20.200.000 on one of the SATA disks. I'll replace the
> drive eventually, but is there a way of finding out what
> file is currently residing in a specific block? I'd prefer
> something a bit more efficient than doing a 'wc' on 300GB
> of data (which also would miss all the directories).  To
> make things more interesting, the disk is 1 of 4 in a RAID5
> array, and is formatted with XFS.
> 
> Best regards,

See xfs_db(8) and its blockget/blockuse commands. 

cheers.

-- 
Nathan
