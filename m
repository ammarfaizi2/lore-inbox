Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbTITRrF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 13:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTITRrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 13:47:05 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:45497 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261914AbTITRrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 13:47:03 -0400
Subject: Re: 2.4.2[12] v VIA Rhine and VIA82x audio (working with a fight)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux@treblig.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030920163835.GA723@gallifrey>
References: <20030920163835.GA723@gallifrey>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064079929.22995.7.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Sat, 20 Sep 2003 18:45:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-20 at 17:38, Dr. David Alan Gilbert wrote:
>   The motherboard has onboard via-rhine ether; this wouldn't work
> with the first kernels I tried.  With 2.4.22 it needs the 'noapic'
> option to work (2.4.22 wouldn't build for me single processor).
> The errors are timeouts on transmit; the same happens on 2.4.21

I've done some work on this for -ac. I thought 2.4.22 had enough stuff
to deal with it (at least for the non ACPI case). VIA v-bus cares that
both PCI_INTERRUPT_PIN and PCI_INTERRUPT_LINE are both set.

> 2) Audio
> 
> This was much more of a fight. The standard 2.4.21/22 via82xxx drivers
> were very problematic.  For example random hanging apps, buzzing when
> an app had sound open but wasn't actually sending stuff, and a complete
> failure to have any sound input.

Do you have VIA 8233 or 8235 hardware ?

> Except for playing CDs - which don't do anything - I suspect that might
> be hardware, but am not sure.

Check there is an analog cable fitted on the CD->Sound. Many new WinXP
boxes are shipped with XP configured to digitally rip the CD data and no
audio link cable. If so you need to pick a different CD player app or
fit the cable.

