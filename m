Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbTDHXyR (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 19:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbTDHXyR (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 19:54:17 -0400
Received: from palrel11.hp.com ([156.153.255.246]:39043 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262620AbTDHXyQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 19:54:16 -0400
Date: Tue, 8 Apr 2003 17:05:53 -0700
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>
Subject: Re: [PATCHES 2.5.67] PCMCIA hotplugging, in-kernel-matching and depmod support
Message-ID: <20030409000553.GA26454@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030408223111.GA25785@bougret.hpl.hp.com> <3E93538C.9010306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E93538C.9010306@pobox.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 06:56:12PM -0400, Jeff Garzik wrote:
> 
> >	Example :
> >	Lucent/Agere Orinoco wireless card :
> >		manfid 0x0156,0x0002
> >		possible drivers : wlan_cs ; orinoco_cs
> >	Intersil PrismII and clones (Linksys, ...) :
> >		manfid 0x0156,0x0002
> >		possible drivers : prism2_cs ; hostap_cs
> >
> >	Please explain me in details how your stuff will cope with the
> >above, and how to make sure the right driver is loaded in every case
> >and how user can control this.
> >	If your scheme can't cope with the simple real life example
> >above (I've got those cards on my desk, and those drivers on my disk),
> >then it's no good to me.
> 
> These cases already exist for PCI, so pcmcia behavior should follow what 
> the kernel does when the PCI core sees such.
> 
> 	Jeff

	I've never heard of a case of PCI-ID collision between two
different manufacturer, so I need to update myself ;-)
	I was already burnt by this mess, as many IrDA users get
confused when ir-usb loads instead of irda-usb, so my experience so
far in handling those case has not been very positive.
	But, I trust you now have things under control ;-)

	Have fun...

	Jean
