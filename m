Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbTKEXLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 18:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTKEXLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 18:11:19 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:4614 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263274AbTKEXLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 18:11:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Denis <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Samuel Kvasnica <samuel.kvasnica@tuwien.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: nforce2 random lockups - still no solution ?
Date: Thu, 6 Nov 2003 01:11:06 +0200
X-Mailer: KMail [version 1.4]
References: <3F95748E.8020202@tuwien.ac.at>
In-Reply-To: <3F95748E.8020202@tuwien.ac.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200311060111.06729.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 October 2003 20:01, Samuel Kvasnica wrote:
> Now, in the system with MSI K7N2 motherboard I have a framegrabber
> (Hauppauge PVR-250) installed, using ivtv driver.
> I'm able to lock-up the system when streaming uncompressed video
> (e.g. cat /dev/yuv0 >/dev/null) and the lockups are also hard, w/o
> debug info. The ivtv driver is using DMA very heavily  but seems to
> work on other chipsets. So these lock-up problems might be rather DMA
> then APIC related. Interesting is that I've never had such a lock-up
> when running WinXP on same computer ( :-) seems impossible), even
> under load and with the framegrabber.

It can be a too-aggressive chipset configuration triggering chipset big.

Maybe do lspci -vvvxxx and it's WinXP equivalent (I think such tool
for Win ought to exist somewhere, although I had no need for it yet)
and compare the result.
--
vda
