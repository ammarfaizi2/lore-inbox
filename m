Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266248AbUFYMF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266248AbUFYMF7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 08:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266717AbUFYMF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 08:05:59 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:27086 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266248AbUFYMFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 08:05:50 -0400
Message-ID: <40DC1513.2070706@comcast.net>
Date: Fri, 25 Jun 2004 08:05:39 -0400
From: David van Hoose <david.vanhoose@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Christoph Hellwig <hch@infradead.org>,
       Helge Hafting <helge.hafting@hist.no>,
       John Richard Moser <nigelenki@comcast.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Collapse ext2 and 3 please
References: <40DB605D.6000409@comcast.net> <40DBED77.6090704@hist.no>	 <40DC0CE0.6040509@comcast.net> <20040625114105.GA28892@infradead.org>	 <40DC1192.7030006@comcast.net> <1088165028.16286.59.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1088165028.16286.59.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All ext3 partitions are labeled as ext3. It still panics.

Regards,
David

Anton Altaparmakov wrote:
> On Fri, 2004-06-25 at 12:50, David van Hoose wrote:
> 
>>yeah.. Really. Here's what I do.
>>
>>I have ext3 partitions, so I decided if they are different partitions, 
>>then I can compile my kernel with ext2 as a module and ext3 builtin.
>>So I do it and reboot. Panic! Reason? Cannot find filesystem for the 
>>root partition.
>>The error is in the kernel itself either way. Pick your reason.
>>1) ext3 is identified as ext2 on bootup.
>>2) There is no fallback to ext3 if ext2 is not found.
>>
>>I'll check this again to be sure on a 2.6 kernel later today, but as far 
>>as 2.4 is concerned my kernel panics.
> 
> 
> Have a look in /etc/fstab, does it say ext3 or ext2 for your root
> partition?  If it says ext2 then of course it panics and Christoph was
> right.  (-;
> 
> Best regards,
> 
> 	Anton

