Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756236AbWKRHdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756236AbWKRHdb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 02:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756237AbWKRHdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 02:33:31 -0500
Received: from terminus.zytor.com ([192.83.249.54]:65201 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1756236AbWKRHda
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 02:33:30 -0500
Message-ID: <455EB72B.1010103@zytor.com>
Date: Fri, 17 Nov 2006 23:32:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Oleg Verych <olecom@flower.upol.cz>
CC: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       vgoyal@in.ibm.com, akpm@osdl.org, rjw@sisk.pl, ebiederm@xmission.com,
       Reloc Kernel List <fastboot@lists.osdl.org>, pavel@suse.cz,
       magnus.damm@gmail.com
Subject: Re: [PATCH 20/20] x86_64: Move CPU verification code to common file
References: <20061117223432.GA15449@in.ibm.com> <20061117225953.GU15449@in.ibm.com> <slrnelt6h7.dd3.olecom@flower.upol.cz> <20061118063802.GE30547@bingen.suse.de> <20061118070101.GA14673@flower.upol.cz> <455EAF54.5090500@zytor.com> <20061118072259.GC14673@flower.upol.cz>
In-Reply-To: <20061118072259.GC14673@flower.upol.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Verych wrote:
> On Fri, Nov 17, 2006 at 10:59:32PM -0800, H. Peter Anvin wrote:
>> Oleg Verych wrote:
>>> It will burn CPU, until power cycle will be done (my AMD64 laptop and
>>> Intel's amd64 destop PC require that). In case of reboot timeout (or
>>> just reboot with jump to BIOS), i will just choose another image to boot
>>> or will press F8 to have another boot device.
>>>
>> That's a fairly stupid argument, since it assumes operator intervention, 
>> at which point you have access to the machine anyway.
> 
> I would never call *power cycle* stupid, just because from physics
> point of veiw.
> 
> Example. I have my flower.upol.cz many kilometers far away from me.
> I used to boot it from that flash (new hardware, sata problems, etc).
> 
> When something goes wrong with rc kernel or power source, bum.
> And i had to move my ass there, just to press reset. Because.

Yes, and you would have to do that to press F8 too.

> While i have "power on, on AC failures" in BIOS, *sometimes* flash
> will not boot (i don't know why, maybe it's GRUB+flash-read,
> or BIOS usb hdd implementation specific).

I was making the point that there is unattended recovery possible.  That 
makes it a significant argument.  That a user on a laptop has to wait 
four seconds pushing the power button is not.

	-hpa
