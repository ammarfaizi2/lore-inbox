Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265878AbVBDUXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265878AbVBDUXB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265198AbVBDUNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:13:17 -0500
Received: from [151.38.86.195] ([151.38.86.195]:49157 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S261708AbVBDUEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:04:51 -0500
In-Reply-To: <20050203104501.GC3144@crusoe.alcove-fr>
References: <20050202155403.GE3117@crusoe.alcove-fr> <51cfdfdc084037ae1e3f164b0c524abc@libero.it> <20050203104501.GC3144@crusoe.alcove-fr>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <157ce1dea9c7fa6f1ff81c5fbef5e641@libero.it>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Daniele Venzano <webvenza@libero.it>
Subject: Re: [RFC] Linux Kernel Subversion Howto
Date: Fri, 4 Feb 2005 21:04:21 +0100
To: Stelian Pop <stelian@popies.net>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/feb/05, at 11:45, Stelian Pop wrote:

>> For now I'm keeping the latest stable 2.6 release of the files I need
>> in the svn repo, then when I need to sync with the rest of the world, 
>> I
>> get the latest -bk patch and see if there are some related changes. If
>> so, I create a new branch, apply the -bk patch (only the interesting
>> part) and then apply my modifications on top of that.
>
> With the 'full' svn solution you lose some storage space but you
> gain in time. The above steps are automatic and you don't have to
> bother looking at the changes, decide if it matters or not, etc.

Well, I just have found a way to download single diffs out of bkbits, 
so I can probably just interface with that. Remember, I have to track 
only two files.
Mine was the point of view of a small kernel worker, I maintain only 
one driver and I don't want to commit more resources to the task than 
what would be reasonable. The difference in storage space is measurable 
in several hundredth of megabytes, and that is a big gain on my poor 
resources.

However, that does not remove any value from your howto, that is both 
complete and useful.

--
Daniele Venzano
http://teg.homeunix.org

