Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282693AbRLBTfb>; Sun, 2 Dec 2001 14:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284283AbRLBTfX>; Sun, 2 Dec 2001 14:35:23 -0500
Received: from clouddancer.com ([64.42.30.110]:41998 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S282693AbRLBTfJ>; Sun, 2 Dec 2001 14:35:09 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: IBM Thinkpad T21: Hotplugging of cdrom and floppy devices
In-Reply-To: <9udhi7$t3$1@phoenix.clouddancer.com>
In-Reply-To: <3C0A4986.8020708@athlon.maya.org> <9udhi7$t3$1@phoenix.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20011202193450.B36E77843A@phoenix.clouddancer.com>
Date: Sun,  2 Dec 2001 11:34:50 -0800 (PST)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, <andihartmann@freenet.de> wrote:
>
>When I put off my floppy-device (/dev/fd1) and put in my cdrom-device 
>(/dev/hdc; both no pcmcia-devices) or vice versa, the kernel doesn't 
>recognize this change. The change - LED of the laptop is blinking until 
>I suspend the laptop for example with apm -s or with the keyboard Fn-F4 
>and rewake it. After this "little sleep", the kernel suddenly knows 
>about the new hardware and it can handle it.
>
>I tested the hotplugging-feature of the kernel 2.4.x - but I couldn't 
>get it working.
>
>Is there any other possibility to give the kernel a chance to detect a 
>hardware change without going through the suspend-mode? I mean, is there 
>a piece of software, which does the same as in the wake-up-situation of 
>the notebook after suspend?

The Thinkpad linux webpages mention : suspend, swap device, unsuspend.

I suspect there is a BIOS function that handles the device change,
since that is where the suspend actually occurs.  Windows must call it
directly.  Hotplugging is for the standard interfaces, the thinkpad
Ultrabay is unique.  You should probably be asking the IBM linux
group.

-- 
Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."

