Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTDOPKk (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 11:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTDOPKk 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 11:10:40 -0400
Received: from zeke.inet.com ([199.171.211.198]:2222 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S261605AbTDOPKj 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 11:10:39 -0400
Message-ID: <3E9C23B3.4090208@inet.com>
Date: Tue, 15 Apr 2003 10:22:27 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [OT] patch splitting util(s)?
References: <3E9B2C38.4020405@inet.com> <20030414215128.GA24096@suse.de> <mailman.1050360781.7083.linux-kernel2news@redhat.com> <200304150047.h3F0lXc22483@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
>>> > I didn't have much luck with googling.  I think the words I used are too 
>>> > generic.  :/
>>> 
>>>Google for diffsplit. Its part of Tim Waugh's patchutils.
>>>Patchutils should be part of pretty much every distro these days too.
>>
>>I'm aware of patchutils.  (Check the 0.2.22 Changelog ;) )  However, 
>>splitdiff doesn't do what I'm after, from my initial look.  Though now 
>>that I think about it, it suggests an alternative solution.  A 
>>'shatterdiff' that created one diff file per hunk in a patch would give 
>>me basically what I want.
> 
> 
> I moaned at Tim until he caved in and added an '-s' option
> couple of weeks ago. It should be in a fresh rawhide srpm.

I'm not finding a -s option in Tim's 0.2.23pre1 release.  Where should I 
be looking for it?

> Mind, you can do what you want even now, with -n (for line numbers)
> and a little bit of sh or perl, but all concievable solutions
> require several passes over the diff, which gets tiresome
> if you diff 2.4.9 (RH 7.2) and 2.4.18 (RH 8.0). The -s option
> does it in one pass.

Thanks,

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

