Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUBXAln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 19:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUBXAln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 19:41:43 -0500
Received: from pxy6allmi.all.mi.charter.com ([24.247.15.57]:30962 "EHLO
	proxy6-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S261779AbUBXAll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 19:41:41 -0500
Message-ID: <403A9E80.608@quark.didntduck.org>
Date: Mon, 23 Feb 2004 19:44:48 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Run cpuid.c and msr.c through Lindent
References: <4037F4E0.6050508@quark.didntduck.org> <20040222064216.GA15101@dingdong.cryptoapps.com>
In-Reply-To: <20040222064216.GA15101@dingdong.cryptoapps.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Sat, Feb 21, 2004 at 07:16:32PM -0500, Brian Gerst wrote:
> 
> 
>>Run cpuid.c and msr.c through Lindent to improve readability.  The
>>only non-whitespace change was to add a missing semicolon after
>>module_exit().
> 
> 
> As much as I had poor/inconsistent formatting, gratuitous whitespace
> changes are really annoying when you have to deal with merging code
> across several kernel versions (as I have had to do) and I really
> prefer to see these things done as the code is fixed/modified.

It's excuses like this that have allowed this crap to endure for so long 
without getting fixed.  What patch do you have for these files that is 
conflicting?  I haven't seen any proposed patches for these two files in 
a long time, and BK only shows one minor change in the last 6 months, so 
I didn't feel that I was going to step on anyone's toes with this patch.

--
				Brian Gerst
