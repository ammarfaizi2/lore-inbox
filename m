Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266298AbUAVVNZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 16:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266331AbUAVVNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 16:13:25 -0500
Received: from dsl-213-023-214-209.arcor-ip.net ([213.23.214.209]:18448 "HELO
	obi.mine.nu") by vger.kernel.org with SMTP id S266298AbUAVVNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 16:13:00 -0500
Subject: Re: 2.6.1 on ATI Rage 128 M3: some thin vertical lines show up
From: Andreas Oberritter <obi@saftware.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <401034E6.70703@t-online.de>
References: <401034E6.70703@t-online.de>
Content-Type: text/plain
Message-Id: <1074805972.2081.85.camel@shiva.eth.saftware.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Jan 2004 22:12:52 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-22 at 21:39, Harald Dunkel wrote:
> Kernel: plain 2.6.1, booted with "vga=0x318"
> Hardware: Dell C600 laptop
> VGA: VGA compatible controller: ATI Technologies Inc Rage Mobility M3 AGP 2x (rev 02)
>       (XFree86 says '"ATI Rage 128 Mobility M3 LF (AGP)" (ChipID = 0x4c46)')
> 
> If I run "make menuconfig" on the frame buffer console,
> then some character cells (e.g. the top line to the right
> of "Linux Kernel v2.6.1 Configuration") contain some thin
> vertical lines in various colors instead of being plain blue.
[...]
> I can't remember having seen this problem with kernel 2.4.22,
> but please don't count on this.

Just to clarify, are you talking about vesafb? I ask, because the
rage128 driver included in the kernel does not support flat panels.
That's the reason why I started a new driver for my Dell C600, which I
haven't ported to 2.6 yet (volunteers are welcome, see
http://www.saftware.de/r128fb/r128fb-20030819.tar.bz2 ;-).

Regards,
Andreas

