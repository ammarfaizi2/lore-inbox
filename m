Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbTCOVKL>; Sat, 15 Mar 2003 16:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261601AbTCOVKL>; Sat, 15 Mar 2003 16:10:11 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:57761 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261595AbTCOVKK>; Sat, 15 Mar 2003 16:10:10 -0500
Date: Sat, 15 Mar 2003 21:18:27 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: war@lucidpixels.com, linux-kernel@vger.kernel.org
Subject: Re: Broadcom BCM5702 Major Problems
Message-ID: <20030315221827.GB26890@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Manfred Spraul <manfred@colorfullife.com>, war@lucidpixels.com,
	linux-kernel@vger.kernel.org
References: <3E732F0F.6000806@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E732F0F.6000806@colorfullife.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15, 2003 at 02:47:59PM +0100, Manfred Spraul wrote:

 > >[*] IO-APIC support on uniprocessors
 > >
 > I think the subject is a bit misleading:
 > There seems to be a problem with interrupt routing if he enables IO-APIC 
 > support, both with a Broadcom nic and a 3com nic.
 > Either the MP table that is supplied by the bios is incorrect [wouldn't 
 > be a big surprise - I think Linux is the only OS that looks at MP tables 
 > of uniprocessor machines], or the ACPI interpreter did something wrong.

I've noticed on two seperate testboxes (x86 and x86-64) that 8139too
won't recieve packets unless I boot with 'noapic acpi=off' now.
And yes, it has to be both those options, one on its own of either
doesn't make the problem go away. 100% reproducable.

Doesn't seem to affect any other drivers I've tried though.

		Dave

