Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271671AbRHQPaS>; Fri, 17 Aug 2001 11:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271673AbRHQPaI>; Fri, 17 Aug 2001 11:30:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54542 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271671AbRHQP34>; Fri, 17 Aug 2001 11:29:56 -0400
Subject: Re: Via usb problems...
To: cbridges@confluencenetworks.com (Curtis Bridges)
Date: Fri, 17 Aug 2001 16:32:48 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Reply-To: linux-usb-devel@lists.sourceforge.net
In-Reply-To: <no.id> from "Curtis Bridges" at Aug 17, 2001 08:17:28 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Xlc8-0007Xv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The work-around for the problem is provided by VIA in the form of some
> updated drivers for windows.  It appears to be some sort of usb filter,
> possibly for low bandwidth USB peripherals.  I suspect this isn't a
> working resolution for most people on this list and I was wondering if
> anyone has been working on this in the kernel?  I might be able to
> provide some more information if it is needed to diagnose and solve the
> problem...

Can you provide me

1.	The lspci -v info for your box (chip revision etc)
2.	Details ont he updated windows drivers (eg URL for)
3.	The USB devices

> Does VIA have any engineers working on linux drivers?

Directly, I don't believe so. However they do provide contact points for
some of us and have provided workarounds for other bugs. We now have a 
mechanism in place for making such requests.

Firstly however I'd like the USB folks to look at the debug and traces to be
sure this isnt a VIA chip bug. If it is I'll take it up with VIA
