Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVCVADt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVCVADt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVCUX7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:59:42 -0500
Received: from fire.osdl.org ([65.172.181.4]:59106 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262144AbVCUXzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:55:32 -0500
Date: Mon, 21 Mar 2005 15:55:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: len.brown@intel.com, duncan.sands@free.fr,
       linux-usb-users@lists.sourceforge.net, gregkh@suse.de,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, bjorn.helgaas@hp.com
Subject: Re: 2.6.11 (stable and -rc) ACPI breaks USB
Message-Id: <20050321155520.6e1d2a87.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0503212329190.6194@alpha.polcom.net>
References: <Pine.LNX.4.62.0503030053120.6789@alpha.polcom.net>
	<20050321142056.7609d615.akpm@osdl.org>
	<Pine.LNX.4.62.0503212329190.6194@alpha.polcom.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski <kangur@polcom.net> wrote:
>
> On Mon, 21 Mar 2005, Andrew Morton wrote:
> 
> > Grzegorz Kulewski <kangur@polcom.net> wrote:
> >>
> >> Hi,
> >>
> >> I just installed 2.6.11 and I was hit by the same bug (or feature?) I
> >> found in -rcs. Basically my USB will work only if acpi=off was passed to
> >> the kernel. It looks like without acpi=off it will assign IRQ 10 and with
> >> acpi=off it will assign IRQ9. It worked at least with 2.6.9. I do not know
> >> if the USB is completly broken but at least my speedtouch modem will not
> >> work (the red led will be on for some time then completly black).
> >>
> >
> > I didn't really follow all the ins and outs on this one.  Will it end up
> > being adequately resolved for 2.6.12?
> 
> It was identified (by Bjorn) to be some ACPI VIA PCI IRQ routing quirk 
> logic change (as far as I understand it). Unfortunatelly it is not good 
> for my board (AMD 761 North and VIA 686B South). Bjorn (huge thanks to 
> him) produced testing patch that fixed it for me. Further patches were 
> presented and discussed in the other thread. The newest one is waiting for 
> final testing from me (in couple of minutes probably). I will CC you on my 
> reply (if you are not already). As of what to do next with this patch (if 
> it still works) Bjorn and others should reply.

Great, thanks.  I dunno if it's really fixed yet, but it's obvious I won't
help anything by spamming people over it, so I'll cross this one off the
list.

