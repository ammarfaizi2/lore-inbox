Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275357AbTHGOFH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275359AbTHGOFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:05:06 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:26755 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S275357AbTHGOEO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:04:14 -0400
Subject: Re: TI yenta-alikes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Tim Small <tim@buttersideup.com>, Pavel Roskin <proski@gnu.org>,
       linux-pcmcia@lists.infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030807141650.C25908@flint.arm.linux.org.uk>
References: <200308062025.08861.daniel.ritz@gmx.ch>
	 <20030806194430.D16116@flint.arm.linux.org.uk>
	 <Pine.LNX.4.56.0308061452310.3849@marabou.research.att.com>
	 <20030806203217.F16116@flint.arm.linux.org.uk>
	 <Pine.LNX.4.56.0308061554480.4178@marabou.research.att.com>
	 <3F317FD7.6020209@buttersideup.com>
	 <Pine.LNX.4.56.0308062301550.1995@marabou.research.att.com>
	 <20030807100211.A17690@flint.arm.linux.org.uk>
	 <1060258695.3123.36.camel@dhcp22.swansea.linux.org.uk>
	 <3F324DDE.3040409@buttersideup.com>
	 <20030807141650.C25908@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060264823.3123.53.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 15:00:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-07 at 14:16, Russell King wrote:
> You can do what you're suggesting as long as you take account of the
> device itself.  However, once you've decided the device isn't setup,
> how can the kernel determine exactly what the _correct_ setup of the
> device is?  You can't say "well, its a PCI1031 device, therefore I'll
> select ISA interrupt mode" because you don't know if it has been
> wired up that way.

Subvendor id I guess - and some kind of heuristic for uninitialized plugin
cards (my guess is "PCI" if it was hotplugged). 

