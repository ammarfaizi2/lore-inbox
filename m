Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbUCEIXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 03:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262250AbUCEIXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 03:23:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51435 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262242AbUCEIXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 03:23:52 -0500
Date: Fri, 5 Mar 2004 09:23:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Olaf Fr?czyk <olaf@cbk.poznan.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 BUG - can't write DVD-RAM - reported as write-protected
Message-ID: <20040305082350.GO31750@suse.de>
References: <1078434953.1961.13.camel@venus.local.navi.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078434953.1961.13.camel@venus.local.navi.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04 2004, Olaf Fr?czyk wrote:
> Hi,
> I switched to 2.6.3 from 2.4.x serie.
> When I mount DVD-RAM it is mounted read-only:
> 
> [root@venus olaf]# mount /dev/dvdram /mnt/dvdram
> mount: block device /dev/dvdram is write-protected, mounting read-only
> [root@venus olaf]#
> 
> In 2.4 it is mounted correctly as read-write.
> 
> Drive: Panasonic LF-201, reported in Linux as:
> MATSHITA        DVD-RAM LF-D200         A120
> 
> SCSI controller: Adaptec 2940U2W

What does cat /proc/sys/dev/cdrom/info say? Do you get any kernel
messages in dmesg when the rw mount fails?

-- 
Jens Axboe

