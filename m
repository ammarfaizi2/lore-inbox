Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVJRWfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVJRWfG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 18:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVJRWfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 18:35:06 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:29452 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932178AbVJRWfF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 18:35:05 -0400
Message-ID: <435578C7.1090504@tmr.com>
Date: Tue, 18 Oct 2005 18:35:51 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Anybody know about nforce4 SATA II hot swapping + linux raid?
References: <4UXuH-EU-31@gated-at.bofh.it> <4XLQk-6Z2-1@gated-at.bofh.it> <4XMt3-7Yt-5@gated-at.bofh.it> <4350A1C5.3080902@shaw.ca>
In-Reply-To: <4350A1C5.3080902@shaw.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Lajber Zoltan wrote:
> 
>> We have about 7 serverraid card from 4L to 5i. All of them is sitting on
>> shelf. They are pain to manage, ipssend tool is weak, serverdirector
>> complicated. And they are slow, the Fusion MPT SCSI with sw raid
>> significant faster, as we measured with bonnie++. Even the old aic7892 is
>> faster (these built-in scsi controllers on xseries motherboards).
> 
> 
> The 6i and 7 series of cards seem to have quite a bit better relative 
> speeds. Certainly the 4Lx cards can be outperformed in simple "hdparm" 
> tests by a 3ware SATA controller/disks of half the price..
> 
> Plus, software RAID can't provide good performance on many server/DB 
> applications without risking data loss in certain cases - for such 
> things one really wants something with a battery-backed cache on it..
> 
I just have a better feeling about hardware when there are dozens of 
multi-TB servers from NY to CA. If it goes down IBM fixes it instead of 
someone trying to get it back up at the console.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
