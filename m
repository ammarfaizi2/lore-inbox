Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWCAC5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWCAC5v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 21:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWCAC5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 21:57:51 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:46797 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932436AbWCAC5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 21:57:50 -0500
In-Reply-To: <20060301004039.GA14229@plexity.net>
References: <200602281229.12887.mbuesch@freenet.de> <44043CEE.70201@pobox.com> <200602281311.59888.mbuesch@freenet.de> <20060301004039.GA14229@plexity.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <81D78F6B-7492-4DE0-A82D-F647869B3A40@kernel.crashing.org>
Cc: Michael Buesch <mbuesch@freenet.de>, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Generic hardware RNG support
Date: Tue, 28 Feb 2006 20:57:46 -0600
To: dsaxena@plexity.net
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Feb 28, 2006, at 6:40 PM, Deepak Saxena wrote:

> On Feb 28 2006, at 13:11, Michael Buesch was caught saying:
>> On Tuesday 28 February 2006 13:07, you wrote:
>>> Michael Buesch wrote:
>>>> Andrew, consider inclusion of the following patch into -mm
>>>> for further testing, please.
>>>>
>>>> ---
>>>>
>>>> This patch adds support for generic Hardware Random Number  
>>>> Generator
>>>> drivers. This makes the usage of the bcm43xx internal RNG through
>>>> /dev/hwrandom possible.
>>>>
>>>> A patch against bcm43xx for your testing pleasure can be found at:
>>>> ftp://ftp.bu3sch.de/misc/bcm43xx-d80211-hwrng.patch
>>>
>>> Please merge with Deepak Saxena's generic RNG stuff, rather than
>>> duplicating efforts.
>>
>> Well, I did not know that someone else already wrote something
>> like this. Do you have any pointers to his stuff (patches)?
>
> Hi, I'll email you the patchset off-list so you can look at the API
> and write the bcm43xx driver against it.  They are a few months old  
> and
> need updating to 2.6.latest and it is on my 2.6.18 TODO. If you  
> search the
> archives there were a few small issues left such as separating out  
> all the
> x86 stuff into separate amd, via, and intel code instead of having  
> a single
> file.

Are the patches in any state to include in -mm?

- kumar
