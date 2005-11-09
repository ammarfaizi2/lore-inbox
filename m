Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVKIMXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVKIMXR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 07:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbVKIMXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 07:23:16 -0500
Received: from main.gmane.org ([80.91.229.2]:62413 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750703AbVKIMXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 07:23:16 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: BadRAM for 2.6.14
Date: Wed, 09 Nov 2005 21:17:40 +0900
Message-ID: <dksph7$opv$1@sea.gmane.org>
References: <20051109095343.GA17048@roonstrasse.net> <1a56ea390511090357m5ff9ababsaff340c757b8ab42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051023)
X-Accept-Language: en-us, en
In-Reply-To: <1a56ea390511090357m5ff9ababsaff340c757b8ab42@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DaMouse wrote:
> On 11/9/05, Max Kellermann <max@duempel.org> wrote:
> 
>>Hi Rick,
>>
>>I have ported your BadRAM patch to the new kernel 2.6.14.  There were
>>a few tiny formal corrections due to patch conflicts; besides that, I
>>did not change anything.
>>
>>To linux-kernel: is there a reason why this patch was never added to
>>Linus' tree?  It helped me save money more than once.

Might be because memmap boot parameter (Documentation/kernel-parameters.txt) is sufficient for most
cases?

I used a machine with 1GB RAM and 3 holes of about 5MB each for almost 2 years.

> Didn't happen to make a x86_64 one did you? Really good job, I love
> this patch so much and I think I'll look into a 64bit variant when I'm
> bored in french or something.

If this get included, a 64bit version would be appreciated though.

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

