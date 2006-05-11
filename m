Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWEKLXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWEKLXb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 07:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWEKLXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 07:23:31 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:29595 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030226AbWEKLXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 07:23:30 -0400
Date: Thu, 11 May 2006 13:23:20 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Jesper Juhl <jesper.juhl@gmail.com>, Joshua Hudson <joshudson@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Stability of 2.6.17-rc3?
In-Reply-To: <200605110119.46822.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.61.0605111319350.32546@yvahk01.tjqt.qr>
References: <bda6d13a0605091340x2e16342v15733b2c9612d985@mail.gmail.com>
 <200605101041.14595.s0348365@sms.ed.ac.uk> <Pine.LNX.4.61.0605110022040.5869@yvahk01.tjqt.qr>
 <200605110119.46822.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Though, Joshua, 2.6.17-rc3 seems to be a rock-solid release. It's safe
>> > enough to diff against and boot, if that's what you want to do.
>>
>> It did not eat the virtual machine so its chances are good. However, I wait
>> for 2.6.17 because of the few XFS fixes gone in since then.
>
>I run a 1TB XFS filesystem on a RAID5 with no ill-effects. I've never 
>experienced data-loss in 2.6, mostly due to conservative options (no 4k 
>stacks, no regparm, XFS only).
>
Oh I must have missed -rc2, in which

Nathan Scott:
      [XFS] Fix superblock validation regression for the zero imaxpct case. 
      [XFS] Fix a writepage regression where we accidentally stopped 
honouring
      [XFS] Fix utime(2) in the case that no times parameter was passed in.
      [XFS] Fix a problem in aligning inode allocations to stripe unit

got in.


Jan Engelhardt
-- 
