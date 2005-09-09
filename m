Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbVIIVTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbVIIVTy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 17:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbVIIVTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 17:19:54 -0400
Received: from mail-out3.fuse.net ([216.68.8.176]:35548 "EHLO smtp3.fuse.net")
	by vger.kernel.org with ESMTP id S1030340AbVIIVTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 17:19:53 -0400
Message-ID: <43215470.3020502@fuse.net>
Date: Fri, 09 Sep 2005 05:22:56 -0400
From: rob <rob.rice@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: swsusp
References: <431E97E5.1080506@fuse.net> <431F42D0.6080304@gmail.com> <4321179B.6080107@fuse.net> <4321C7FF.8030109@gmail.com>
In-Reply-To: <4321C7FF.8030109@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:

>>>
>> it crashes the kernel with atempt to kill init or it trys to load a 
>> memory image that was never saved
>> I can't get it to boot for the first time so it can save a memory image
>>
>
> Strange...
> Have you read the documentation? use resume2 instead of resume and so on?
>
> Suspend2 works.. and solves many problems of suspend1... I recommend 
> you invest some more time making it work.
>
> Best Regards,
> Alon Bar-Lev.
>
yes and it dosen't behave as expected the noresume2 dosen't work at all
I even had to "rdev -R /dev/hda1 " the kernel just to get it to find the 
root parttion it was erroring with
(3.1) unrecnised device i even had to down the 2.6.13 source just to try 
it the patch would not apply
to a 2.6.12.5 source code

I have seen swsusp work on this laptop I haven't even seen swsusp2 even 
boot
on the fastest computer I have acess to there is a 2 1/2 hour built of 
the kernel
and I have to remove the hard drive from the laptop install it in the 
desk top get
the kernel on it reflash the BIOSreset al the hard ware settings reset 
the clock
just to see the kernel crash on boot up I have done this 3 times I have 
doubts
that this patch was ever ment for laptops the doucmentation isen't even 
included
in the source package
(laptops are not always on the net or always easy to get on the net )

I see it as a good thing it hasen't ben included in the kernel tree
