Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266546AbUG0UFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266546AbUG0UFs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 16:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266552AbUG0UFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 16:05:48 -0400
Received: from mail.tmr.com ([216.238.38.203]:1548 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266546AbUG0UFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 16:05:35 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: A users thoughts on the new dev. model
Date: Tue, 27 Jul 2004 16:08:30 -0400
Organization: TMR Associates, Inc
Message-ID: <ce6c83$i0o$1@gatekeeper.tmr.com>
References: <cdr5i3$568$1@terminus.zytor.com><cdr5i3$568$1@terminus.zytor.com> <20040723214055.GR19329@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1090958403 18456 192.168.12.100 (27 Jul 2004 20:00:03 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <20040723214055.GR19329@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Fri, Jul 23, 2004 at 01:58:27PM +0000, H. Peter Anvin wrote:
> 
>>Followup to:  <cdpee5$otu$1@gatekeeper.tmr.com>
>>By author:    Bill Davidsen <davidsen@tmr.com>
>>In newsgroup: linux.dev.kernel
>>
>>>I confess I feel that this new model is a return to the bad old days 
>>>when the stable tree wasn't. Sounds as if Andrew is bored with the idea 
>>>of letting 2.7 be the development tree and just being the gatekeeper of 
>>>STABLE new features for 2.6. Perhaps 2.7 should be opened and Andrew 
>>>will have a place to play, and features can drift to 2.6 more slowly.
>>>
>>
>>I think the discussion we had at the kernel summit has been somewhat
>>misrepresented by LWN et al.  What we discussed was really more of a
>>"soft fork", with the -mm tree serving the purpose of 2.7, rather than
>>a hard fork with a separate maintainer and putting ourselves in
>>back/forward-porting hell all over again.
>>
>>Note that Andrew's -mm tree *specificially* has infrastructure to keep
>>changes apart and thus backporting to 2.6 mainstream of patches which
>>have proven themselves becomes trivial.
>>...
> 
> 
> One problem from a user's point of view is that removal of obsolete code 
> that works sufficiently for some users.
> 
> Andrew said explicitely in a mail to linux-kernel that he'd consider 
> removing devfs "mid-2005" - and it didn't sound as if this would only be 
> a -mm "feature".
> 
> Even if 2.7 is started this doesn't has to imply that it has to be 
> flooded with big changes - a short 2.7 with relativley few invasive 
> changes might also be an option.

I would consider removing devfs or cryptoloop invasive, since they would 
mean some people just flat-out couldn't use the kernel with their 
existing system.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
