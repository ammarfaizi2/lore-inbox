Return-Path: <linux-kernel-owner+w=401wt.eu-S1751908AbXAVPNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbXAVPNz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbXAVPNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:13:55 -0500
Received: from sitar.i-cable.com ([203.83.115.100]:65238 "HELO
	sitar.i-cable.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751906AbXAVPNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:13:54 -0500
Message-ID: <00ad01c73e37$e60c2ef0$28df0f3d@kylecea1512a3f>
From: "kyle" <kylewong@southa.com>
To: "Steve Cousins" <steve.cousins@maine.edu>,
       "Justin Piszcz" <jpiszcz@lucidpixels.com>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <001801c73e14$c3177170$28df0f3d@kylecea1512a3f> <Pine.LNX.4.64.0701220717200.30260@p34.internal.lan> <45B4D0ED.7030500@maine.edu>
Subject: Re: change strip_cache_size freeze the whole raid
Date: Mon, 22 Jan 2007 23:13:34 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Justin Piszcz wrote:
>> Yes, I noticed this bug too, if you change it too many times or change it 
>> at the 'wrong' time, it hangs up when you echo numbr > 
>> /proc/stripe_cache_size.
>>
>> Basically don't run it more than once and don't run it at the 'wrong' 
>> time and it works.  Not sure where the bug lies, but yeah I've seen that 
>> on 3 different machines!
>
> Can you tell us when the "right" time is or maybe what the "wrong" time 
> is?  Also, is this kernel specific?  Does it (increasing 
> stripe_cache_size) work with RAID6 too?
>
> Thanks,
>
> Steve

I think if your /sys/block/md_your_raid6/md/ have a file 
"stripe_cache_size", then it should works with raid6 too.

Kyle

