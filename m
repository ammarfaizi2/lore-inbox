Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269347AbUIIFbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269347AbUIIFbI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 01:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269351AbUIIFbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 01:31:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26066 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269347AbUIIFaq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 01:30:46 -0400
Message-ID: <413FEA72.2030705@pobox.com>
Date: Thu, 09 Sep 2004 01:30:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
CC: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Current state of UML - some help needed from mainline.
References: <200408190301.i7J30xek004150@ccure.user-mode-linux.org> <413B76DB.5010600@pobox.com> <200409061956.34557.blaisorblade_spam@yahoo.it> <200409072013.49494.blaisorblade_spam@yahoo.it>
In-Reply-To: <200409072013.49494.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BlaisorBlade wrote:
> For LKML: I'm not subscribed, so don't forget to CC me.
> On Monday 06 September 2004 19:56, BlaisorBlade wrote:
> 
>>On Sunday 05 September 2004 22:28, Jeff Garzik wrote:
>>
>>>Overall I am really impressed.  Like other arches in the Linux kernel,
>>>it is IMO very important to be able to work "out of the box", without
>>>patches.
> 
> Yes - especially when microAPI changes happen every day, as of 2.6. I've just 
> downloaded a snapshot including the merge, so I'll be able to merge some 
> little fixes which have happened since.
> 
> Do you think that keeping a UML tree for new, experimental features is a good 
> idea, or that this role should go to -mm?
> 
> I ask this also because I don't know how much would help general review for 
> new features.

It's up to you.  Andrew pulls several BitKeeper trees into his -mm tree, 
so you could do both if you wished.  If you do that, though, just make 
sure that the code you push is in a state that's ready for review and 
testing :)


> For instance, the "hostfs" feature is in the middle of a rewrite and the new 
> code is still very broken (the current release says more or less "VFS: busy 
> inodes after unmount - self destroying in 5 seconds. Have a nice day", but 
> maybe this is fixed; plus has a number of other bugs).

I usually create a new "patch queue" for experimental features, to make 
sure that (a) it's seperated from the main testing branch but (b) it's 
easy to merge it back into the main testing branch when it's ready.  If 
you use BitKeeper, this is accomplished simply by creating another 
cloned repository.

	Jeff


