Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbVKQTFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbVKQTFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVKQTFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:05:19 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:29824 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S932490AbVKQTFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:05:18 -0500
Message-ID: <437CCE4B.3020900@wolfmountaingroup.com>
Date: Thu, 17 Nov 2005 11:39:07 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compaq Presario "reboot" problems
References: <Pine.LNX.4.61.0511171314440.10063@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511171314440.10063@chaos.analogic.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Verified. I saw this problem a few weeks back and I am running Windows 
2000 and 2003 on separate systems now. Windows 2000
is such a pig it needs its own system in any event.

Jeff

linux-os (Dick Johnson) wrote:

>With Linux-2.4.26 I reported that if a Compaq gets rebooted while
>running Linux-2.4.26, it will not be able to restart Windows 2000.
>It cam restart Linux fine. Today, I tried the same thing with
>Linux-2.6.13.4. It fails, too.
>
>The symptoms are that you just "reboot" Linux. When the GRUB loader
>comes up, I select my Windows-2000/professional. That M$ Crap comes
>up to where it's just about to start the high-resolution screen.
>Then it stops forever, no interrupts, no nothing. I need to disconnect
>power and remove the battery to recover.
>
>It appears as though Linux is still restarting as a "warm boot",
>rather than a cold boot (in other words, putting magic in the
>shutdown byte of CMOS) so the hardware doesn't get properly
>initialized. Would somebody please check this out. When changing
>operating systems, you need a cold-boot.
>
>Cheers,
>Dick Johnson
>Penguin : Linux version 2.6.13.4 on an i686 machine (5589.44 BogoMips).
>Warning : 98.36% of all statistics are fiction.
>.
>
>****************************************************************
>The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
>
>Thank you.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

