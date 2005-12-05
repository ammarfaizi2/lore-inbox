Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbVLEXK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbVLEXK2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbVLEXK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:10:28 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:3062 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964844AbVLEXKS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:10:18 -0500
Message-ID: <4394A664.8060703@tmr.com>
Date: Mon, 05 Dec 2005 15:43:16 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Ranson <david@unsolicited.net>
CC: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de> <20051203162755.GA31405@merlin.emma.line.org> <4391CEC7.30905@unsolicited.net> <1133630012.6724.7.camel@localhost.localdomain> <4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de> <4391E52D.6020702@unsolicited.net>
In-Reply-To: <4391E52D.6020702@unsolicited.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ranson wrote:
> Adrian Bunk wrote:
> 
> 
>>- support for ipfwadm and ipchains was removed during 2.6
>>
>>
> 
> Surely this one had loads of notice though? I was using iptables with
> 2.4 kernels.
> 
> 
>>- devfs support was removed during 2.6
>>
>>
> 
> Did this affect many 'real' users?
> 
> 
>>- removal of kernel support for pcmcia-cs is pending
>>- ip{,6}_queue removal is pending
>>- removal of the RAW driver is pending
>>
>>
> 
> I don't use any of these. I guess pcmcia-cs may be disruptive for laptop
> users.

You don't seem to grasp that thousands of people DO use these features, 
and by removing the features those users are blocked from security, 
reliability, and performance related changes. And there are a number of 
other features mentioned
> 
> So far I don't see evidence to suggest huge repeated userspace breakages
> between Kernel versions that were implied earlier in this thread.
> Whatever, we aren't going to see any more stable branches without
> volunteers to do the spadework. As has been pointed out, this won't
> always be an easy task.

To a large extent I don't think it's a needed task. If new stuff doesn't 
work that doesn't hurt established uses, it's only when changes like the 
PCI rethink go in that existing users are impacted. As long as things 
aren't taken OUT, the current kernel is usefully stable.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

