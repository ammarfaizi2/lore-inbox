Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVEZV22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVEZV22 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 17:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVEZV2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 17:28:09 -0400
Received: from smtpout.mac.com ([17.250.248.86]:54774 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261802AbVEZV02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 17:26:28 -0400
In-Reply-To: <42962180.6080800@tmr.com>
References: <4847F-8q-23@gated-at.bofh.it> <E1Db3zm-0004vF-9j@be1.7eggert.dyndns.org> <4295005F.nail2KW319F89@burner> <8E909B69-1F19-4520-B162-B811E288B647@mac.com> <42962180.6080800@tmr.com>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <ED51E7F7-FB05-4812-AFE0-0CD93D07439F@mac.com>
Cc: linux-kernel@vger.kernel.org, 7eggert@gmx.de
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Date: Thu, 26 May 2005 17:26:09 -0400
To: Bill Davidsen <davidsen@tmr.com>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 26, 2005, at 15:20:32, Bill Davidsen wrote:
>> There is a specific reason that the numbers are  
>> _kernel_internal_!!!   I set up
>> my udev so that my green CD burner is /dev/green_burner, and my  
>> blue  CD burner
>> is /dev/blue_burner.  Please tell me again why exactly I can't  
>> just  give the
>> option -dev=/dev/green_burner and have it use my green CD burner?
> You do realize that you can?

Well, yes, and I do all the time, but the dammed deprecation warning  
is just plain
stupid.  That's not the deprecated method, that's the reasonable method.

> So having you see the information to set up your udev is a good use  
> and having Joerg use them is bad? If you want to have names mapped  
> into "humanspace" why is program use bad? I agree numbers are ugly  
> and confusing, but if I wanted someone to make those choices for me  
> I'd run another o/s.

I don't use the three-number made-up SCSI-over-USB IDs that Joerg was  
complaining
about being unavailable.  I have mine set up based on the UUID of the  
burner.  I'm
sorry for being unclear, but my objection is to his desire to expose  
the SCSI IDs
to userspace as the primary naming scheme, when said SCSI IDs are  
frequently just
made up by the kernel for USB devices, etc.

>>>> (I'm running as user, and cdrecord has no need for suid bits.)
>
> Which is fine if you have a system to dedicate to burning CDs. But  
> on a loaded system Joerg is right, you get a better burn if you  
> don't have the burnfree used. Like any other minor defect it may or  
> may not bite you, a lot of them will measurably reduce your CD  
> capacity, which actually will bite you if you are trying to use  
> every last byte.

Agreed.  My personal gripe is that it screams at me even when I'm  
just doing a
quickie burn of a 60MB debian netinst CD for a one-use-only thing.

> There is an option if you would read the manpage. There are  
> legitimate complaints, this doesn't seem to be one of them.

Ah, crap.  I just realized that some accidental disk corruption took  
a chunk out of
the middle of my copy of the manpage.  A reinstall of the package  
seems to have
fixed the problem.  Sorry about the noise.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



