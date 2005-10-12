Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbVJLRLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVJLRLm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 13:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVJLRLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 13:11:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:47325 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932369AbVJLRLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 13:11:41 -0400
Date: Wed, 12 Oct 2005 10:11:15 -0700
From: Greg KH <greg@kroah.com>
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.14-rc4 echi_hcd hangs machine
Message-ID: <20051012171115.GB11935@kroah.com>
References: <20051012084533.GB26865@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051012084533.GB26865@gollum.tnic>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 10:45:33AM +0200, Borislav Petkov wrote:
> Hi Greg,
>    I tried to boot 14-rc4 yesterday but it fails when it reaches the init code
>    forthe usb host controllers und freezes the machine totally:
>    
> <snip>
>    [4294687.294000] usb usb3: Manufacturer: Linux 2.6.14-rc4 uhci_hcd
>    [4294687.300000] usb usb3: SerialNumber: 0000:00:1d.2
>    [4294687.321000] hub 3-0:1.0: USB hub found
>    [4294687.326000] hub 3-0:1.0: 2 ports detected
>    [4294689.363000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low)	-> IRQ 20
>    [4294689.372000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
>    [4294689.378000] ehci_hcd 0000:00:1d.7: debug port 1
>    <EOF>
> </snip>
> 
> This happens with rc3 too so I thought it had something in common with this bug:
> http://bugzilla.kernel.org/show_bug.cgi?id=5350 but it doesn't seem so. I've got
> USB debugging enabled but the above is all you get over the serial console. The
> rc? series don't have a kernel debugger so is there any other way to debug this?

Can you file a new bug at bugzilla.kernel.org and we can take it from
there?

thanks,

greg k-h
