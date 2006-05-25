Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWEYP5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWEYP5P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 11:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWEYP5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 11:57:15 -0400
Received: from [195.23.16.24] ([195.23.16.24]:19085 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1030234AbWEYP5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 11:57:14 -0400
Message-ID: <4475D3CE.3010309@grupopie.com>
Date: Thu, 25 May 2006 16:57:02 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Jon Smirl <jonsmirl@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       Dave Airlie <airlied@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <9e4733910605241656r6a88b5d3hda8c8a4e72edc193@mail.gmail.com>	 <4475007F.7020403@garzik.org> <200605250237.20644.dhazelton@enter.net>	 <44756E70.9020207@garzik.org> <9e4733910605250704m68235d88lcd8eaedfda5e63cf@mail.gmail.com> <4475C845.5000801@garzik.org>
In-Reply-To: <4475C845.5000801@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>[...]
>> would also pick up the ability to reset secondary cards at boot.
> 
> But if you think the kernel will grow an x86 emulator, you're dreaming. 
> That's what initramfs and friends are for.

I really don't want to push the x86 emulator idea, especially when 
kernel gurus that I respect very much, such as yourself, seem to be 
against it.

It just seems awkward that everyone thinks its fine to have a 30Kb ACPI 
interpreter in the kernel that loads a DSDT and executes it, but a 30Kb 
x86 emulator that loads a video ROM and executes it is completely absurd.

Some PC's need an ACPI interpreter to function properly, some video 
cards need a x86 emulator to function properly.

Why is everyone so keen on keeping the video drivers crippled, but no 
one says "ACPI should be done from user space with user mode helpers"?

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
