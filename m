Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUHBQih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUHBQih (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 12:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUHBQih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 12:38:37 -0400
Received: from mail.tmr.com ([216.238.38.203]:29447 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266613AbUHBQif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 12:38:35 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: ide-cd problems
Date: Mon, 02 Aug 2004 12:41:44 -0400
Organization: TMR Associates, Inc
Message-ID: <celqbj$gh9$1@gatekeeper.tmr.com>
References: <20040730193651.GA25616@bliss><20040730193651.GA25616@bliss> <20040731153609.GG23697@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1091464371 16937 192.168.12.100 (2 Aug 2004 16:32:51 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <20040731153609.GG23697@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Jul 30 2004, Zinx Verituse wrote:
> 
>>I'm going to bump this topic a bit, since it's been a while..
>>There are still some issues with ide-cd's SG_IO, listed from
>>most important as percieved by me to least:
>>
>> * Read-only access grants you the ability to write/blank media in the drive
>> * (with above) You can open the device only in read-only mode.
> 
> 
> That's by design. Search linux-scsi or this list for why that is so.

So is the only solution to disallow user access to the device? 
Operationally that is inconvenient in some cases, but every user 
community has a few ill-intentioned people, and student groups may be 
somewhat heavy on that. Security is more important than convenience, but 
both are desirable.

We could go to burning all local reference data on CD-R instead of 
CD-RW, have a separate CD-R drive, but as noted all of those are 
undesirable drains on time and money. Clearly having some twit rewite 
the CD-RW with their own information is even more undesirable, if that 
wasn't clear ;-)

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
