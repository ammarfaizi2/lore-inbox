Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266165AbUFYMy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266165AbUFYMy3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 08:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266167AbUFYMy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 08:54:29 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:58843 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266165AbUFYMyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 08:54:09 -0400
Message-ID: <40DC2063.7070109@comcast.net>
Date: Fri, 25 Jun 2004 08:53:55 -0400
From: David van Hoose <david.vanhoose@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Philip R. Auld" <pauld@egenera.com>
CC: Christoph Hellwig <hch@infradead.org>,
       Helge Hafting <helge.hafting@hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Collapse ext2 and 3 please
References: <40DB605D.6000409@comcast.net> <40DBED77.6090704@hist.no> <40DC0CE0.6040509@comcast.net> <20040625114105.GA28892@infradead.org> <40DC1192.7030006@comcast.net> <20040625084836.A2205@vienna.EGENERA.COM>
In-Reply-To: <20040625084836.A2205@vienna.EGENERA.COM>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That could be a problem. How do I check its configuration?

Regards,
David

Philip R. Auld wrote:
> Rumor has it that on Fri, Jun 25, 2004 at 07:50:42AM -0400 David van Hoose said:
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
>>
> 
> 
> 
> Make sure any initrd you are using is not ext2 based.
> 
> Cheers,
> 
> Phil
> 
> 
> 
>>Regards,
>>David
>>
>>PS. Shut up with the cheap insults. I have empirical evidence supporting 
>>my claim. Meaning there exists a bug somewhere.
>>
>>Christoph Hellwig wrote:
>>
>>>On Fri, Jun 25, 2004 at 07:30:40AM -0400, David van Hoose wrote:
>>>
>>>
>>>>If ext2 and ext3 are different filesystems, why does my kernel panic if 
>>>>I include ext3 in the kernel make ext2 a module?
>>>
>>>
>>>My kernel doesn't, must be a problem in front of the computer.
>>>
>>>
>>
