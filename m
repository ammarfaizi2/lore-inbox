Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWFBMWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWFBMWO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 08:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWFBMWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 08:22:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45033 "EHLO
	out.lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751308AbWFBMWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 08:22:06 -0400
Subject: Re: skge killing off snd_via686 interrupts on Fedora Core 5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sitsofe Wheler <sitsofe@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <pan.2006.05.27.14.43.20.450376@yahoo.com>
References: <pan.2006.05.27.14.43.20.450376@yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Jun 2006 18:03:37 +0100
Message-Id: <1149181417.12932.44.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-05-27 at 15:43 +0100, Sitsofe Wheler wrote:
> We have a few machines which have been upgraded to to D-Link System Inc
> DGE-530T Gigabit Ethernet adaptors. The unfortunate news is that shortly
> after this was done people found that programs were either going
> into the D state or hanging while trying to access the soundcard using
> ALSA. Looking in the logs turned up this message:
> 
> irq 11: nobody cared (try booting with the "irqpoll" option)

If running with irqpoll fixes it then I'd suggest looking for BIOS
updates. The older VIA boards often had buggy IRQ router information.
Are you updating from a 100Mbit card in the same slot or onboard
ethernet ?


