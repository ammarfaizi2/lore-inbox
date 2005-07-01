Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263427AbVGASj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbVGASj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 14:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263428AbVGASj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 14:39:59 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:49595 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S263427AbVGASj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 14:39:57 -0400
Date: Fri, 1 Jul 2005 20:40:09 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: christos gentsis <christos_gentsis@yahoo.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI-X support
Message-ID: <20050701184009.GA2034@ucw.cz>
References: <42C58203.40606@yahoo.co.uk> <Pine.LNX.4.61.0507011357290.5350@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507011357290.5350@chaos.analogic.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 02:00:15PM -0400, Richard B. Johnson wrote:
> On Fri, 1 Jul 2005, christos gentsis wrote:
> 
> >Hello
> >
> >I have a friend that his Msc project is related with the development
> >over a PCI-X card. the problem is that he do not know if the Linux
> >kernel support the PCI-X bus. i try to find something related with the
> >PCI-X in the kernel source but i didn't found any file or folder with a
> >relevant name... Does any one know if PCI-X bus supported from Linux and
> >if no how can he patch the kernel to support it...?
> >
> >Thanks
> >Chris
> 
> Sure PCI-X is just PCI/66 with 64-bits. It's just like PCI/66
> from a software standpoint.
 
Not really. 64-bit 66MHz PCI is normal PCI, within the PCI 2.1 spec.
Common PCI-X is running at 133MHz, 64-bit wide.

You're correct, though, that from the software standpoint it's not much
different and Linux supports it natively. I'm not sure about MSI-X
extensions, though.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
