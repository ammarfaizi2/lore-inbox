Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263082AbTCWPmK>; Sun, 23 Mar 2003 10:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263083AbTCWPmK>; Sun, 23 Mar 2003 10:42:10 -0500
Received: from main.gmane.org ([80.91.224.249]:44495 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S263082AbTCWPmJ>;
	Sun, 23 Mar 2003 10:42:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicholas Wourms <dragon@gentoo.org>
Subject: Re: 2.5 BK boot hang after ide
Date: Sun, 23 Mar 2003 10:48:32 -0500
Message-ID: <3E7DD750.70804@gentoo.org>
References: <20030323143108.30109.qmail@linuxmail.org> <200303231534.50634.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@main.gmane.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:
>>I'm experiencing exactly the same as you: 2.5 won't
>>continue past IDE. I've tried 2.5.65-ac3, 2.5.65-bk3
>>and 2.5.65-mm4. All of them fail at the same point.
>>I've tried using ACPI, APM, disabling preempt, TCQ,
>>enabling SysRq support, but had no luck.
>>
>>The machine is a Pentium 4 2.0Gz, with a QDI
>>PlatiniX 2D/533-A (i845E), 2 UDMA100 disks
>>(Seagate ST380021A 80GB and IBM-DTLA-307030
>>20GB), a Pioneer DVD-ROM and Sony CRX185E3).
> 
> 
> 2.5 BK worked for me two days ago, i.e. before Alan's
> latest IDE changes went in.  Did any previous version
> work for you?
> 

I'm seeing the exact same behavior for AMD Opus.  It just 
hangs after the hdd, no messages.  I've been dropping 
printk's in random places, but still haven't figured it out. 
  Please see the "IDE Todo" thread for more info.  Also, it 
was working for me 2 days ago as well.

Cheers,
Nicholas


