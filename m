Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266138AbRF2R5z>; Fri, 29 Jun 2001 13:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbRF2R5p>; Fri, 29 Jun 2001 13:57:45 -0400
Received: from [194.213.32.142] ([194.213.32.142]:6404 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266132AbRF2R5h>;
	Fri, 29 Jun 2001 13:57:37 -0400
Message-ID: <20010629003836.E525@bug.ucw.cz>
Date: Fri, 29 Jun 2001 00:38:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: steve.snyder@philips.com, linux-kernel@vger.kernel.org
Subject: Re: Any gain to supporting only a single PCMCIA slot?
In-Reply-To: <0056910012761441000002L112*@MHS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <0056910012761441000002L112*@MHS>; from steve.snyder@philips.com on Wed, Jun 20, 2001 at 04:56:40PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> PCMCIA/Cardbus controllers typically (always?) support 2 slots, and system 
> resources are allocated to support those slots.  When you build PCMCIA 
> support into your kernel, you are implicitly asking for both slots to be 
> supported.  I'm wondering if it would be worthwhile to let the user opt out of 
> supporting one of the slots.  
> 
> Compaq, in their finite wisdom, only provides a single Type2 Cardbus slot 
> on my Presario 1260 notebook.  The controller (a TI PCI1131, see below) 
> can handle 2 slots, of course, but only a single physical connector is 
> present on this machine.  Therefore I will never get the use of half of 
> the controller, including the I/O address, etc. that the kernel has 
> allocated for it.  

> Would it be worth the savings in system resources to allow support for 
> only a single slot?

Probably not.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
