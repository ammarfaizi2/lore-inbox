Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751893AbWK1Uuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbWK1Uuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 15:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbWK1Uuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 15:50:51 -0500
Received: from lmailproxy02.edpnet.net ([212.71.1.195]:13019 "EHLO
	lmailproxy02.edpnet.net") by vger.kernel.org with ESMTP
	id S1751893AbWK1Uuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 15:50:50 -0500
Date: Tue, 28 Nov 2006 21:50:45 +0100
From: Laurent Bigonville <l.bigonville@edpnet.be>
To: Andreas Jellinghaus <aj@ciphirelabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O2micro smartcard reader driver.
Message-Id: <20061128215045.ccccab06.l.bigonville@edpnet.be>
In-Reply-To: <456C294E.4060006@ciphirelabs.com>
References: <20061127182817.d52dfdf1.l.bigonville@edpnet.be>
	<456C294E.4060006@ciphirelabs.com>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2006 13:19:26 +0100
Andreas Jellinghaus <aj@ciphirelabs.com> wrote:

> maybe post once more, and make clear whether you are looking for:

Yep it's about a smartcard reader. This reader need a kernel module to
be acceded by pcscd.

> 
> also o2micro might also create pcmcia card readers for either.
> maybe let us know what kind of device you exactly have and how
> it is connected (if build in... lspci / lsusb would see pci or
> usb devices, pcmcia devices are found by the kernel I think).

bigon@imladris:~$ lspcmcia -vvvv
Socket 0 Bridge:        [yenta_cardbus]         (bus ID: 0000:02:06.0)
        Configuration:  state: on       ready: unknown
--none--
--none--
Socket 1 Bridge:        [yenta_cardbus]         (bus ID: 0000:02:06.1)
        Configuration:  state: on       ready: unknown
                        Voltage: 5.0V Vcc: 5.0V Vpp: 5.0V
--none--
--none--
Socket 1 Device 0:      [-- no driver --]       (bus ID: 1.0)
        Configuration:  state: on
        Product Name:   O2Micro SmartCardBus Reader V1.0 
        Identification: manf_id: 0xffff card_id: 0x0001
                        prod_id(1): "O2Micro" (0x97299583)
                        prod_id(2): "SmartCardBus Reader" (0xb8501ba9)
                        prod_id(3): "V1.0" (0xe611e659)
                        prod_id(4): --- (---)
Socket 2 Bridge:        [yenta_cardbus]         (bus ID: 0000:02:06.3)
        Configuration:  state: on       ready: unknown
                        Voltage: 5.0V Vcc: 5.0V Vpp: 5.0V
--none--
--none--
Socket 2 Device 0:      [-- no driver --]       (bus ID: 2.0)
        Configuration:  state: on
        Product Name:   O2Micro SmartCardBus Reader V1.0 
        Identification: manf_id: 0xffff card_id: 0x0001
                        prod_id(1): "O2Micro" (0x97299583)
                        prod_id(2): "SmartCardBus Reader" (0xb8501ba9)
                        prod_id(3): "V1.0" (0xe611e659)
                        prod_id(4): --- (---)

02:06.0 CardBus bridge: O2 Micro, Inc. OZ711M3/MC3 4-in-1 MemoryCardBus
Controller 
02:06.1 CardBus bridge: O2 Micro, Inc. OZ711M3/MC3 4-in-1 MemoryCardBus
Controller 
02:06.2 System peripheral: O2 Micro, Inc. OZ711Mx 4-in-1 MemoryCardBus
Accelerator 
02:06.3 CardBus bridge: O2 Micro, Inc. OZ711M3/MC3 4-in-1
MemoryCardBus Controller

