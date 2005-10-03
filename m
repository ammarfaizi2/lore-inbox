Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbVJCPZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVJCPZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVJCPZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:25:28 -0400
Received: from dvhart.com ([64.146.134.43]:61074 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932284AbVJCPZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:25:27 -0400
Date: Mon, 03 Oct 2005 08:25:28 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Dave Hansen <haveblue@us.ibm.com>,
       Magnus Damm <magnus@valinux.co.jp>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/07][RFC] i386: NUMA emulation
Message-ID: <86300000.1128353125@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.62.0510030810290.11541@qynat.qvtvafvgr.pbz>
References: dlang@dlang.diginsite.com <Pine.LNX.4.62.0510030802090.11541@qynat.qvtvafvgr.pbz> <83890000.1128352138@[10.10.2.4]> <Pine.LNX.4.62.0510030810290.11541@qynat.qvtvafvgr.pbz>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--David Lang <david.lang@digitalinsight.com> wrote (on Monday, October 03, 2005 08:13:09 -0700):

> On Mon, 3 Oct 2005, Martin J. Bligh wrote:
> 
>> --David Lang <david.lang@digitalinsight.com> wrote (on Monday, October 03, 2005 08:03:44 -0700):
>> 
>>> On Mon, 3 Oct 2005, Martin J. Bligh wrote:
>>> 
>>>> But that's not the same at all! ;-) PAE memory is the same speed as
>>>> the other stuff. You just have a 3rd level of pagetables for everything.
>>>> One could (correctly) argue it made *all* memory slower, but it does so
>>>> in a uniform fashion.
>>> 
>>> is it? I've seen during the memory self-test at boot that machines slow down noticably as they pass the 4G mark.
>> 
>> Not noticed that, and I can't see why it should be the case in general,
>> though I suppose some machines might be odd. Got any numbers?
> 
> just the fact that the system boot memory test takes 3-4 times as long with 8G or ram then with 4G of ram. I then boot a 64 bit kernel on the system and never use PAE mode again :-)
> 
> if you can point me at a utility that will test the speed of the memory in different chunks I'll do some testing on the Opteron systems I have available. unfortunantly I don't have any Xeon systems to test this on.

Mmm. 64-bit uniproc systems, with > 4GB of RAM, running a 32 bit kernel
don't really strike me as a huge market segment ;-)

M.

