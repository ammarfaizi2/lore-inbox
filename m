Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312337AbSCUBiX>; Wed, 20 Mar 2002 20:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312338AbSCUBiO>; Wed, 20 Mar 2002 20:38:14 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:15634 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312337AbSCUBh5>;
	Wed, 20 Mar 2002 20:37:57 -0500
Date: Wed, 20 Mar 2002 17:36:59 -0800
From: Greg KH <greg@kroah.com>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre3-ac4: ATTRIB_NORET
Message-ID: <20020321013659.GI7736@kroah.com>
In-Reply-To: <E16nje1-0002oN-00@the-village.bc.nu> <3C990E9E.CC23F0AA@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 20 Feb 2002 20:09:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 09:35:10AM +1100, Eyal Lebedinsky wrote:
> BTW, this undef is still around too:
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.19-pre3-ac4/kernel/drivers/hotplug/ibmphp.o
> depmod:         IO_APIC_get_PCI_irq_vector

Can you send me your .config?  The symbol is exported properly in -ac4,
but it seems that some .configs allow the ibmphp driver to be built,
even though they should not be.

thanks,

greg k-h
