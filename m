Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbVLSPxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVLSPxG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 10:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVLSPxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 10:53:06 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:481 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964780AbVLSPxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 10:53:04 -0500
Date: Mon, 19 Dec 2005 16:53:01 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Roger Heflin <rheflin@atipa.com>
cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Dianogsing a hard lockup
In-Reply-To: <EXCHG2003SAQV6uPDVn00000602@EXCHG2003.microtech-ks.com>
Message-ID: <Pine.LNX.4.61.0512191645450.21973@yvahk01.tjqt.qr>
References: <EXCHG2003SAQV6uPDVn00000602@EXCHG2003.microtech-ks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I got the rt2500usb driver to blow up nicely if I used the
>default ieee* routines from the kernel and not the ones that
>came with the rt2500 drivers, you might want to verify which
>ieee* that you are using.  Using the ones that came with the
>rt2500 seem to work, or at least not crash the kernel out.

The rt2500-1.1.0-b3 (not the same as rt2500pci!) package does not include 
its own ieee tree yet, so that can't be the issue. Anyway, I tried the card 
in on a different box, and it worked there. Strange enough that it's 
always the motherboard which fails it. The one where it does not work is a 
VIA something motherboard with an AMD K6-2/500 CPU. 


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
