Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266864AbRHWOSH>; Thu, 23 Aug 2001 10:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266921AbRHWOR5>; Thu, 23 Aug 2001 10:17:57 -0400
Received: from cmr1.ash.ops.us.uu.net ([198.5.241.39]:18415 "EHLO
	cmr1.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S266864AbRHWORm>; Thu, 23 Aug 2001 10:17:42 -0400
Message-ID: <3B8510DE.3AF272BA@uu.net>
Date: Thu, 23 Aug 2001 10:19:10 -0400
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.78 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: ledzep37@home.com, shawnm@splorkin.com, linux-kernel@vger.kernel.org
Subject: Re: Shutdown and power off on a multi-processor machine
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile a kernel with apm support and add the following to your
lilo.conf:

append="apm=power-off"

Alex


---------------------------------

I too am having trouble powering off and rebooting an SMP machine. It 
is a Tyan Tiger 230. I have tried to report this a few times with 
little to no response. The last kernel that worked for me in this 
respect was 2.4.6-ac2. I have tried linus' and alan's kernels both with 
no success. I have tried configuring all kernel with APM soft-power 
off, real-mode power off (I enable power-off even though the rest of APM 
is broken on SMP), ACPI (multiple setups), and nothing at all. None of 
these kernel/configuration combos allow me to shutdown or reboot my 
machine. I would like to be able to and I know the board still works 
because Windows 2000/XP (even though I hate using them) both manage to 
shutdown/reboot the machine properly. I have everything I can think of 
copiled in statically instead of as modules and also have PNPBIOS enable 
in the kernel and the BIOS. Any help would be appreciated. 

Jordan 

Shawn McGovern wrote: 
> 
> I have a need for a headless machine to power off at the end of shutdown, 
> but cannot get it to work for smp kernels. I tried 2.2.14, and 2.4.9, 
> built with smp and apm. If there is a way to make this work, I would 
> really appreciate any advice. If it cannot be done I would sure like to 
> know that too, so I can stop banging my head on this particular wall. 
> Please send responses to me directly as I am not on this list. TIA. 
> 
> Cheers, 
> Shawn 
>
