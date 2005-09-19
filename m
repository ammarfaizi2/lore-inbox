Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVISFl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVISFl2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 01:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVISFl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 01:41:28 -0400
Received: from mail.dvmed.net ([216.237.124.58]:49030 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932317AbVISFl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 01:41:27 -0400
Message-ID: <432E4F7A.9040605@pobox.com>
Date: Mon, 19 Sep 2005 01:41:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Wu <flamingice@sourmilk.net>
CC: Christoph Hellwig <hch@infradead.org>,
       James Ketrenos <jketreno@linux.intel.com>,
       NetDev <netdev@vger.kernel.org>, ieee80211-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ieee80211 updates
References: <4327625D.10808@linux.intel.com>	<20050914105409.GB30645@infradead.org> <43285ADF.5030506@linux.intel.com>	<20050917092846.GA14083@infradead.org> <432E1069.8010102@pobox.com> <20050919004450.16m2d1hn7les0o00@www.sourmilk.net>
In-Reply-To: <20050919004450.16m2d1hn7les0o00@www.sourmilk.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Wu wrote:
> If it has a version, then only the maintainer can submit patches - 

False.  Presence of an optional label in source code files does not 
change the fundamental rules of open source, or the processes 
surrounding patch merging in the Linux kernel.  Anybody who feels the 
version number should be changed is welcome to submit a patch.  And a 
reviewer along the line is welcome to reject such a patch, if they think 
it is unwarranted.


> otherwise the
> version is useless for identifying what code you're running. (unless other

False.  We have plenty of examples of slower-moving drivers where 
community consensus often dictates a version number change.


> submitters decide to alter the version too, which is probably not a good 
> idea)

For any given driver/subsystem/whatever version number in the kernel, 
ultimately a submittor changes the version and one or more reviewers 
approve this, by pulling the change into their tree.  Your "probably not 
a good idea" is the 100% case here, including the master version number 
in ./Makefile.


>>> That early and often thing is true for drivers aswell, the intel 
>>> wireless
>>> driver are so hopelessly out of date in mainline just after 
>>> submission that
>>> it's not funny anymore.  Hopefully we'll have a mainline maintainer for
>>> them soon that imports everything important from intel and other 
>>> contributors.
>>
>>
>> Patience:  We still have over 20 patches to merge, before even getting
>> to the ipw updates.
>>
> I wish those patches were submitted and merged quickly when they were 
> created
> instead of piling up. Other people can't get patches merged because it 

Agreed.


> Other people can't get patches merged because it
> would
> break the chain of patches. Patches are being sent too late and 
> and infrequently.. 

Patience.  We've got to balance kernel hackers' insatiable desire for 
cleanups, with the desire of users and driver developers to move forward 
with Linux wireless support.

Since Intel has useful stuff, stuff which affects a wide range of 
hardware owned by Linux users, it's worth waiting a bit to let them 
catch up.  Of course, if it takes forever to merge their stuff, someone 
else will inevitably come along and speed up the process.  Open source 
at work.

Currently, it has rather been like a clock algorithm:  merge initial 
ieee80211 code from Intel.  Accept months worth of cleanups from 
community.  Accept unifying updates from Jouni.  Begin merging work from 
Jiri and SuSE.  Now the clock hand points at Intel again, and they've 
been waiting a while to send useful stuff.

People are slowly converging at a decent solution, while at the same 
moving wireless hardware support forward.  The need to improve the 
wireless API is balanced with the need to keep wireless hardware working 
(and/or enable new wireless hardware).

This convergence will be attained more rapidly once the community starts 
WORKING TOGETHER, rather than sending me competing patches.  Person A 
breaks Person B's work.  And then back again.

	Jeff


