Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTFPOrd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 10:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTFPOrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 10:47:33 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:8381 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263918AbTFPOrc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 10:47:32 -0400
Date: Mon, 16 Jun 2003 16:58:34 +0200
From: Dominik Brodowski <linux@brodo.de>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: mikpe@csd.uu.se, Russell King <rmk@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.71 cardbus problem + possible solution
Message-ID: <20030616145834.GA11097@brodo.de>
References: <16109.50492.555714.813028@gargle.gargle.HOWL> <20030616153253.A13312@flint.arm.linux.org.uk> <16109.54908.249375.482633@gargle.gargle.HOWL> <1055775186.587.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055775186.587.2.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 04:53:07PM +0200, Felipe Alfaro Solana wrote:
>
> I must agree with. I think backwards compatibility is important if we
> want widespread adoption of 2.6 from the beginning. But there's a
> question I had in mind for long time: is cardmgr really needed? Isn't
> hotplug more than enough to handle CardBus devices?

One aim of my work is to deprecate cardmgr for both CardBus (32-bit) and
PCMCIA (16-bit) devices. For CardBus, most pieces should be there already,
for PCMCIA the road is much longer.

	Dominik
