Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281075AbRKYVeK>; Sun, 25 Nov 2001 16:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281077AbRKYVeC>; Sun, 25 Nov 2001 16:34:02 -0500
Received: from hermes.domdv.de ([193.102.202.1]:6929 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S281075AbRKYVdw>;
	Sun, 25 Nov 2001 16:33:52 -0500
Message-ID: <XFMail.20011125223206.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <006701c175f1$d9b10630$0f00a8c0@minniemouse>
Date: Sun, 25 Nov 2001 22:32:06 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Jon <marsaro@interearth.com>
Subject: Re: i815 Card ...Machine Freezes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can reproduce this (2.4.15aa1).
MSI-6215 Booksize, Kernel APM (monolithic kernel, i.e. no modules), no BIOS
power management, no X11, no framebuffer, just plain 80x25.
Symptoms: Console blanks but no DPMS blanking (monitor goes not to powersaving
mode). The system is online (Internet, ISDN, ppp). Then scanning the system
using Nessus locks up the system solid. Nothing happens when there's no
ISDN/PPP activity. Didn't try this with LAN activity. No problems with a kernel
without any power management support.

On 25-Nov-2001 Jon wrote:
> Power Management in the BIOS on or compiled into your Kernel?
> 
> Regards,
> 
> Jon
> ----- Original Message -----
> From: "Sid Carter" <sidcarter@symonds.net>
> To: <linux-kernel@vger.kernel.org>
> Sent: Sunday, November 25, 2001 1:32 AM
> Subject: i815 Card ...Machine Freezes
> 
> 
>> Hi,
>>
>> My Machine with a Intel i815 card hangs if it is not used for
>> sometime. The monitor goes blank and after sometime if I don't use the
>> machine , the system hangs. I can't even use the power switch to
>> poweroff the machine. I have to pull out the power cable from the back
>> of the machine. Kernel am using is 2.4.14 with SGi's XFS Patch.
>>
>> And when I am using X, If I switch from X to console and vice-versa
>> more than once, my machine hangs. Is this a known problem ? The logs
>> show no errors at all. Let me know if more info is required.
>>
>> The relevant output of lspci below:
>>
>> 00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory
> Controller Hub (rev 02)
>> 00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics
> Controller] (rev 02)
>>
>> TIA
>> Regards
>>         Carter
>> --
>> The only difference between your girlfriend and a barracuda is the
> nailpolish.
>>
>> Sid Carter                                                   Debian
> GNU/Linux.
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
