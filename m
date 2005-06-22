Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbVFVDaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbVFVDaX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 23:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVFVD3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 23:29:39 -0400
Received: from mail.dvmed.net ([216.237.124.58]:59050 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262723AbVFVD0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 23:26:52 -0400
Message-ID: <42B8DA6D.9080608@pobox.com>
Date: Tue, 21 Jun 2005 23:26:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, jbenc@suse.cz
Subject: Re: -mm -> 2.6.13 merge status (wireless)
References: <20050620235458.5b437274.akpm@osdl.org>	<20050621141930.GB2015@openzaurus.ucw.cz> <20050621130250.78759088.akpm@osdl.org>
In-Reply-To: <20050621130250.78759088.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
> 
>>Hi!
>>
>>
>>>This summarises my current thinking on various patches which are presently
>>>in -mm.  I cover large things and small-but-controversial things.  Anything
>>>which isn't covered here (and that's a lot of material) is probably a "will
>>>merge", unless it obviously isn't.
>>
>>I'd like to ask about 802.11 stack and ipw2100 in particular... Is it
>>"small enough that it did not need mentioning"?
>>Working wireless in mainline would be great...
> 
> 
> That's up to Jeff.

802.11 stack is still too ipw-specific.

Someone needs to get together another driver using 802.11 stack (such as 
HostAP, the original location of much of the code).

So, the merge criteria is:  something other than ipw uses it.

Otherwise, it'll never be generic...

	Jeff, who has several SuSE wireless patches to merge still



