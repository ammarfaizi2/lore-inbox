Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264412AbUGYU5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbUGYU5r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 16:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUGYU5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 16:57:47 -0400
Received: from main.gmane.org ([80.91.224.249]:13000 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264412AbUGYU5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 16:57:45 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Frederik Himpe <fhimpe@pandora.be>
Subject: Re: 2.6.7-ck5: System hangs under constant load
Date: Sun, 25 Jul 2004 22:57:39 +0200
Message-ID: <pan.2004.07.25.20.57.36.483562@pandora.be>
References: <200407252227.05580.rototor@rototor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: d5e0b8ea.kabel.telenet.be
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2004 22:27:05 +0200, Emmeran Seehuber wrote:

> Hello everybody!
> 
> I'm using a 2.6.7 kernel with the ck5 patch (gentoo ck-sources). But the
> problem I have may not directly be related to this kernel version, because
> I had it a few times already with other 2.6.x kernels.
> 
> When I put the machine under constant load (e.g. emerge of kde 3.3beta2),
> it works for some hours without problems. But then the machine suddenly
> hangs. "Hang" means that no keyboard or mouse input works (even SysRq
> doesn't work), the screen freezes and the cpu seems to go into a loop. The
> system is a laptop and I hear the fan spin loudly. And the fan doesn't
> stop to spin nor turns down the sound, even after some hours. (Well, I
> start the emerge and then let the computer alone for some hours, in the
> hope that it finishes it ... when I come back, it hangs)

Interesting, as I'm having also a problem with random hangs since kernel
2.6.6 (2.6.5 and before worked fine), also on a laptop. Which laptop do
you have? I'm using a Compaq EVO N1020v, with this hardware:

00:00.0 Host bridge: ATI Technologies Inc RS200/RS200M AGP Bridge [IGP 340M] (rev 02)
00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 340M]
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:0a.0 CardBus bridge: Texas Instruments PCI4410 PC card Cardbus Controller (rev 02)
00:0a.1 FireWire (IEEE 1394): Texas Instruments PCI4410 FireWire Controller (rev 02)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 20)
00:0c.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
00:11.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
00:13.0 USB Controller: NEC Corporation USB (rev 41)
00:13.1 USB Controller: NEC Corporation USB (rev 41)
00:13.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon IGP 340M

Frederik

