Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWFMNiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWFMNiH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 09:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWFMNiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 09:38:07 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:4251 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750742AbWFMNiF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 09:38:05 -0400
Message-ID: <448EBEF9.9040808@aitel.hist.no>
Date: Tue, 13 Jun 2006 15:34:49 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Gerrit Huizenga <gh@us.ibm.com>
CC: Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <E1FolFA-0007RU-Ab@w-gerrit.beaverton.ibm.com>
In-Reply-To: <E1FolFA-0007RU-Ab@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerrit Huizenga wrote:
> On Fri, 09 Jun 2006 09:09:01 PDT, Linus Torvalds wrote:
>   
>> On Fri, 9 Jun 2006, Gerrit Huizenga wrote:
>>     
>>> Jeff's approach taken to the rediculous would mean that we'd have
>>> ext versions 1-40 by now at least.  I don't think that helps much,
>>> either.
>>>       
>> On the other hand, I _guarantee_ you that it helps that we have ext2-3, 
>> and not just ext2 (nobody even tried to keep ext1 compatible, thank the 
>> Gods).
>>     
>  
> I had originally argued for ext4 as well based on the fact that it would
> allow lots of potential cleanups & simplifications and at the same time
> would allow a break in the on disk filesystems layout.
>
> These changes don't yet change the actual on-disk layout and that might
> be something that would be done if ext4 were a real, new filesystem.
>
> But then how long until ext4 is used enough to be put into production?
>   
No problem.  It didn't take long for ext3 - it won't take long for ext4.
First, you have developers and some enthusiasts using it.
Then, you get the thousands of people who like living
on the edge using ext4. As soon as it doesn't have bad known bugs.
Then some distros pick it up, wanting to be first with
large-disk support.
After that, it is considered "harmless".

If a break in on-disk layout is useful, then the time is now while
a new fs is introduced anyway.  It could be 7 years to the next chance.

Helge Hafting


