Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTLDC6O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 21:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTLDC6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 21:58:14 -0500
Received: from mail.netzentry.com ([157.22.10.66]:23558 "EHLO netzentry.com")
	by vger.kernel.org with ESMTP id S261575AbTLDC6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 21:58:12 -0500
Message-ID: <3FCEA2AD.5040805@netzentry.com>
Date: Wed, 03 Dec 2003 18:57:49 -0800
From: "b@netzentry.com" <b@netzentry.com>
Reply-To: b@netzentry.com
Organization: b@netzentry.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: recbo@nishanet.com
CC: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >Bob wrote:
 >Local APIC locked up with nforce2 and VIA,
 >impossibly serious with nforce2 and non-amd
 >offboard ide controller cards. BIOS flash made
 >problems go away.
 >
 >I experienced the lockups when using promise and
 >siig sis ide hd controller pci cards. I still had problems
 >with a 3ware card.
 >
 >Flashing the bios solved all problems. Now I run
 >both the via and nforce2 mboards with APIC and
 >Local APIC on in kernel. I'm running six ide drives,
 >four on a 3ware pci hd controller card using ide-scsi.
 >
 >I got sound working on nforce2, and nvidia ti4200
 >agp8 vid card(nvidia drivers crash X but agpgart
 >with X "nv" instead of "nvidia" works in 2D well),
 >but not usb. The sound config problem was fixed
 >by "ln -s sound/dsp2 /dev/dsp". The apps only
 >look for /dev/dsp.
 >
 >-Bob

Do you think that motherboard maker was really at fault or
did they genuinely fix a grotesque error. Were any changes
in the BIOS-change-list relevant to fixing up this APIC
problem in Linux?

Can you provide the following:
- which motherboard
- which bios revs (the broken one and the fixed one)
- which kernel are you running (is it vanilla, from a dist,
recompiled)
- lspci
- cat /proc/interrupts
- dmesg
- .config from kernel (if not stock from dist)

I really, really hope this problem can be solved without
a BIOS upgrade because getting board manufacturers to do
anything is very difficult.


