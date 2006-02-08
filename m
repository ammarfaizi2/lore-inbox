Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWBHWxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWBHWxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 17:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWBHWxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 17:53:55 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:10455 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1030231AbWBHWxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 17:53:54 -0500
Message-ID: <43EA7680.6000207@tlinx.org>
Date: Wed, 08 Feb 2006 14:53:52 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: "Changelog-2.6.15": missing signoffs, descriptions
References: <43E935BA.8050605@tlinx.org> <43E943FD.7090508@tlinx.org> <20060208193202.GA8275@agluck-lia64.sc.intel.com>
In-Reply-To: <20060208193202.GA8275@agluck-lia64.sc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luck, Tony wrote:
> On Tue, Feb 07, 2006 at 05:06:05PM -0800, Linda Walsh wrote:
>   
>> Actually, ("talking" to myself?), parsing this file a bit more,
>> I find many (~134) that are missing "Sign-offs".
>>
>> I take it that "Sign-off"s are also "optional" on commits
>> and represent that the author specified under the "commit"
>> tag did not need a "Sign-off"?
>>     
> Most of them do
> appear to be an author not signing off on his own work when working in
> their own git tree.  Jeff Garzik seems to be an expert at this with 70
> commits where he is listed as Author, but there is no signed-off-by line.
> Linus is in second place with 8, but most of those were simply changing
> the release in the Makefile for each "-rcN".  The 2 that weren't were
> Linus fixing a silly typo and reverting a previous commit, perhaps these
> were deliberately not signed?  Then there is a long tail...
I suppose I'm unclear as to why sign-offs were added to the GIT
change-log entries in the first place.

I thought Sign-offs were added to provide an "accountability" trail for
*ALL* new lines of code going into the kernel.  I though it was desired
to know "Who" made or added "What" changes into the kernel to ensure
that added code could be traced to its source to protect against
infringement claims that might arise as well as verifying that changes
had been reviewed for sanity and someone wasn't unintentionally or
deliberately adding "suspect" or "insecure" code.

Given human nature, I'm guessing there isn't sufficient concern about
this issue until we've been bitten several times: hard. 

Sigh.

Linda





