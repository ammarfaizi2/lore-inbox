Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267218AbUBMWnA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 17:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267256AbUBMWm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 17:42:58 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:1550 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S267218AbUBMWlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 17:41:42 -0500
Date: Fri, 13 Feb 2004 23:39:49 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File system performance, hardware performance, ext3, 3ware RAID1, etc.
Message-ID: <20040213223949.GA13937@alpha.home.local>
References: <402C0D0F.6090203@techsource.com> <20040213055350.GG29363@alpha.home.local> <402D235F.7030401@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402D235F.7030401@techsource.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 02:19:59PM -0500, Timothy Miller wrote:
 
> Assuming that the "buffered" speeds are being buffered by the OS, we'll 
> ignore those.  I am therefore observing that the writes to a single 
> drive are 3 to 4 times faster than they are through the RAID controller, 
> even with the 3ware write cache ON.
> 
> Does that make any sense?

Well, it reminds me a disk I had problems with several years ago. It had
a few defects in the FAT area, which were relocated at the end. Performance
was terrible since the head had to move constantly. It took ages to install
Win31 on it, so it finally was returned to the vendor. But in your case it
seems a little bit different since you experience slow writes anywhere on
the medium. Would it be possible that your controller does something like
read-modify-write because of too big chunk size ?

Regards,
Willy

