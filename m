Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263074AbVCEMZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263074AbVCEMZT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 07:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbVCEMZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 07:25:19 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:39580 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S263074AbVCEMXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 07:23:19 -0500
Message-ID: <4229A4B4.1000208@drzeus.cx>
Date: Sat, 05 Mar 2005 13:23:16 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>, Ian Molton <spyro@f2s.com>,
       Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH][MMC] Secure Digital (SD) support
References: <422701A0.8030408@drzeus.cx> <20050305113730.B26541@flint.arm.linux.org.uk>
In-Reply-To: <20050305113730.B26541@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Thu, Mar 03, 2005 at 01:22:56PM +0100, Pierre Ossman wrote:
>  
>
>>Here are the patches for Secure Digital support that I've been sitting 
>>on for a while. I tried to get some feedback on inclusion of this 
>>previously but since I didn't get any I'll just submit the thing.
>>It was originally diffed against 2.6.10 but it applies to 2.6.11 just 
>>fine (only minor fuzz).
>>    
>>
>
>Can we please come to a consensus about GEN_FL_REMOVABLE.  After
>talking to other kernel developers, particularly in the block
>interface area, I am convinced that it is fundamentally incorrect
>to set this flag for MMC/SD devices.
>
>Unfortunately, it appears that you're not convinced.  This needs
>resolving since it is an interface issue.
>
>  
>
Oh, sorry. That part wasn't supposed to be included in there.
As I haven't found any applications depending on any specific behaviour 
then I'm quite content with your behaviour :)
I can make a new patch or you can just undo that line once you've 
applied the current one.

Rgds
Pierre

