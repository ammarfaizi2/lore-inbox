Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265871AbUFYMlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265871AbUFYMlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 08:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265874AbUFYMlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 08:41:08 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:19406 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265871AbUFYMlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 08:41:04 -0400
Message-ID: <40DC1D55.8020701@comcast.net>
Date: Fri, 25 Jun 2004 08:40:53 -0400
From: David van Hoose <david.vanhoose@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
CC: Anton Altaparmakov <aia21@cam.ac.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Helge Hafting <helge.hafting@hist.no>,
       John Richard Moser <nigelenki@comcast.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Collapse ext2 and 3 please
References: <Pine.LNX.4.44.0406251402240.15676-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0406251402240.15676-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> On Fri, 25 Jun 2004, David van Hoose wrote:
> 
>>[root@bahamut root]# /sbin/tune2fs -l /dev/sda2 | grep -i journal
>>Filesystem features:      has_journal filetype needs_recovery sparse_super
>>Journal inode:            8
>>Journal backup:           inode blocks
>>
> 
> 
> Ok, fine, and what does your /etc/lilo.conf or /etc/grub.conf look like?  
> Are you passing "root=/dev/sda2" or "root=LABEL=/" to the kernel?

I use Grub.
root=/dev/sda2

Regards,
David
