Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265278AbTFUTIN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 15:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265279AbTFUTIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 15:08:13 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:58124 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265278AbTFUTIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 15:08:12 -0400
Subject: Re: [CFT] Enable Cardbus bursting
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030621184231.B28984@flint.arm.linux.org.uk>
References: <20030621184231.B28984@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1056223333.921.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 21 Jun 2003 21:22:13 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-21 at 19:42, Russell King wrote:
> Before I push this to Linus, I'd like people with TI cardbus bridges to
> test this patch and ensure that there are no unfortunate side effects.

# lspci
...
00:0c.0 CardBus bridge: Texas Instruments PCI4450 PC card Cardbus
Controller
00:0c.1 CardBus bridge: Texas Instruments PCI4450 PC card Cardbus
Controller
...

Currently running on 2.5.72-mm2 + Cardbus bursting on my NEC laptop. I
haven't detected any problem so far but I'll stay tuned :-)

