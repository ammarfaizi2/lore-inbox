Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTEVIYm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 04:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTEVIYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 04:24:41 -0400
Received: from [62.67.222.139] ([62.67.222.139]:32222 "EHLO kermit")
	by vger.kernel.org with ESMTP id S262589AbTEVIYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 04:24:16 -0400
Date: Thu, 22 May 2003 10:31:30 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: Dima Brodsky <dima@cs.ubc.ca>
Subject: Re: 2.5.69 won't boot (take 2)
Message-ID: <20030522083130.GA3769@synertronixx3>
Reply-To: konsti@ludenkalle.de
References: <20030522064235.GA14168@columbia.cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030522064235.GA14168@columbia.cs.ubc.ca>
X-PGP-Key: http://www.ludenkalle.de/konsti/pubkey.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 11:42:35PM -0700, Dima Brodsky wrote:
> 2.5.69 won't boot on a:

Ok, here too, I tried it yesterday. 1st I thought I forgot CONFIG_VT
too, but then I realized the HDD and floppy LED is lightning for ever!

Sadly I have a modern USB keyboard, so I think the kernel morse codes
don't get on its leds in this early stage...

Host bridge: Silicon Integrated S 730 Host (rev 2).
IDE interface: Silicon Integrated S 5513 [IDE] (rev 208).
PCI bridge: Silicon Integrated S 5591/5592 AGP (rev 0).
Ethernet controller: Realtek Semiconducto RTL-8139/8139C/8139C (rev 16).
VGA compatible controller: Silicon Integrated S SiS630 GUI Accelerat
(rev 49).

> gcc 3.2.3
> glibc 2.3.2
> modutils 2.4.22

Here too...

> CONFIG_ACPI=y

Disable this, worked here.
Now an 2.5.69-mm7 is up and running here, but floppy LED is always
lightning...

Konsti
