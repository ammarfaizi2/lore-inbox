Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135246AbRECVvM>; Thu, 3 May 2001 17:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135251AbRECVvC>; Thu, 3 May 2001 17:51:02 -0400
Received: from asooo.flowerfire.com ([63.104.96.247]:23522 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S135246AbRECVuv>; Thu, 3 May 2001 17:50:51 -0400
Message-Id: <200105032150.QAA11098@asooo.flowerfire.com>
Date: Thu, 3 May 2001 14:50:48 -0700
Content-Type: text/plain;
	format=flowed;
	charset=us-ascii
X-Mailer: Apple Mail (2.388)
From: Ken Brownfield <brownfld@irridia.com>
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0 (Apple Message framework v388)
In-Reply-To: <Pine.LNX.4.10.10105031614270.4386-100000@coffee.psychology.mcmaster.ca>
Subject: Re: 2.4.4 Kernel - ASUS CUV4X-DLS Question
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The failure mode I'm seeing is that the timer interrupt disappears.  
Hard to schedule processes at that point.  I'm not seeing the IRQ issues 
personally.

HP's LP1000r machine uses ServerWorks, but still shows the problem.  I 
only have access to HP SMP hardware currently, but they all have the 
same issue.  I've heard of Tyan and Asus issues (not just the one 
recently posted), though I have an LX machine that has been okay with 
2.4.

I've seen the VIA issues, but they aren't related from what I can tell.
--
Ken.

On Thursday, May 3, 2001, at 01:17 PM, Mark Hahn wrote:

>> I just wanted to throw in my two cents and say that there appear to be
>> widespread issues with the APIC code in 2.4.x.  I'm tempted to stick my
>
> are there any known problems on non-VIA boards?  BX seems to work fine,
> and I haven't heard of any problems from serverworks people.
>
> I'm guessing (wag) that there's some VIA-specific thing that needs
> to be done to get the PIT timer working with io-apic.  no real problem
> with apic/ioapic, just some little divergence on VIA's part.
>
>> from APICitis.  I realize there are different failure modes and I 
>> assume
>> different issues are involved within the APIC code.
>
> are there?  I haven't heard anything except "hangs on boot except with
> noapic".
