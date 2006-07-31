Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWGaH3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWGaH3E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWGaH3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:29:04 -0400
Received: from [219.153.9.10] ([219.153.9.10]:46029 "EHLO iblink.com.cn")
	by vger.kernel.org with ESMTP id S964808AbWGaH3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:29:03 -0400
Message-ID: <44CDB135.8080401@idccenter.cn>
Date: Mon, 31 Jul 2006 15:28:53 +0800
From: kernel <linux@idccenter.cn>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>, jdi@l4x.org
CC: linux-kernel@vger.kernel.org
Subject: Re: XFS Bug null pointer dereference in xfs_free_ag_extent
References: <44BF29CD.1000809@l4x.org> <44CB0BF7.6030204@idccenter.cn> <44CB1303.7010303@l4x.org> <20060731094424.E2280998@wobbly.melbourne.sgi.com> <44CDA156.6000105@idccenter.cn> <20060731165522.K2280998@wobbly.melbourne.sgi.com>
In-Reply-To: <20060731165522.K2280998@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=GB18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I format the same partition and restart the testing server before each 
testing.
I'vs tested on each format at least twenty times.
With XFS and SAN, This crash happens on every bonnie++ testing.

And I have tested such things on another mathine, results are same.


Nathan Scott wrote:
> On Mon, Jul 31, 2006 at 02:21:10PM +0800, kernel wrote:
>   
>> Test again......very strange.
>> I can easily reproduce it on the XFS with SAN(FLX380) connected with a 
>> qlogic 2400 FC card.
>>     
>
> Eggshellent... can you reproduce it with each of those changes
> (below) backed out of your tree please?  Else, git bisect is our
> next best bet.  Thanks!
>
>   
>>> Is this easily reproducible for you?  I've not seen it before, and
>>> the only possibly related recent changes I can think of are these:
>>>
>>> http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e63a3690013a475746ad2cea998ebb534d825704
>>>
>>> http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d210a28cd851082cec9b282443f8cc0e6fc09830
>>>
>>> Could you try reverting each of those to see if either is the cause?
>>>       
>
> cheers.
>
>   
