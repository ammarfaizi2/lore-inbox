Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263199AbVCEGbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbVCEGbs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 01:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbVCEG0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 01:26:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:32141 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263085AbVCEGWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 01:22:52 -0500
Message-ID: <42294D7D.60509@osdl.org>
Date: Fri, 04 Mar 2005 22:11:09 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shawn Starr <shawn.starr@rogers.com>
CC: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
References: <11099685952869@kroah.com> <200503050057.44233.shawn.starr@rogers.com>
In-Reply-To: <200503050057.44233.shawn.starr@rogers.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> How does this fit into Rusty's trivial patch bot?  This process will fold that 
> into a formal method now?
> 
> Shawn.

Nope, no comparison or interaction really.  x.y (linux-release)
isn't meant for trivial patches at all, whereas trivial isn't
meant for critical patches either.

> 
>>List:       linux-kernel
>>Subject:    [RFQ] Rules for accepting patches into the linux-releases tree
>>From:       Greg KH <greg () kroah ! com>
>>Date:       2005-03-04 22:21:46
>>Message-ID: <20050304222146.GA1686 () kroah ! com>
>>[Download message RAW]
>>
>>Anything else anyone can think of?  Any objections to any of these?
>>I based them off of Linus's original list.
>>
>>thanks,
>>
>>greg k-h
>>
>>------
>>
>>Rules on what kind of patches are accepted, and what ones are not, into
>>the "linux-release" tree.
>>
>> - It can not bigger than 100 lines, with context.
>> - It must fix only one thing.
>> - It must fix a real bug that bothers people (not a, "This could be a
>>   problem..." type thing.)
>> - It must fix a problem that causes a build error (but not for things
>>   marked CONFIG_BROKEN), an oops, a hang, or a real security issue.
>> - No "theoretical race condition" issues, unless an explanation of how
>>   the race can be exploited.
>> - It can not contain any "trivial" fixes in it (spelling changes,
>>   whitespace cleanups, etc.)


-- 
~Randy
