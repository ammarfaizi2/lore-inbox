Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbSLZBmc>; Wed, 25 Dec 2002 20:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSLZBmc>; Wed, 25 Dec 2002 20:42:32 -0500
Received: from [66.21.109.1] ([66.21.109.1]:45831 "EHLO
	mail.dynastytechnologies.net") by vger.kernel.org with ESMTP
	id <S261701AbSLZBmc> convert rfc822-to-8bit; Wed, 25 Dec 2002 20:42:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ro0tSiEgE <lkml@ro0tsiege.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4 series: IDE driver
Date: Wed, 25 Dec 2002 19:53:49 -0600
User-Agent: KMail/1.4.3
References: <200212251134.gBPBYxJ29966@oboe.it.uc3m.es> <200212251931.50379.lkml@ro0tsiege.org> <20021226014457.GA4263@gtf.org>
In-Reply-To: <20021226014457.GA4263@gtf.org>
Cc: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212251953.49344.lkml@ro0tsiege.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the kernel is 2.4.21-pre2. At first I had ACPI enabled, and it would 
not boot at all. The last kernel message was showing the ACPI info (release 
version, etc) and it just froze right there, no oops or anything. Now I have 
no power management whatsoever compiled in and I'm getting the hard drive 
errors. I can't boot it long enough to d/l hdparm to turn off DMA. I turned 
"32-bit I/O" off in the BIOS, now it locks within seconds of completely 
booting up. Any help is appreciated.

On Wednesday 25 December 2002 19:44, you wrote:
> On Wed, Dec 25, 2002 at 07:31:50PM -0600, Ro0tSiEgE wrote:
> > I own an HP Pavilion ze4145 notebook, and the ALi5x3 chipset bombs after
> > about 30-40mins of use with "hda: lost interrupt" commands, and this
> > continues until I cut the power, though sometimes after about an hour it
> > will reset and go on, but it is very iffy. I noticed that "32-bit I/O"
> > was disabled by default in the BIOS, however I have enabled it. Is this a
> > problem in the kernels ALi drivers or what? The XP install that came with
> > it works fine. What suggestions to fixing this? Thanks
>
> What kernel version?  I'm sorry if I missed it.
>
> Do you have ACPI enabled?
>
> Try booting with "acpi=off", or with "noapic".
>
> 	Jeff
