Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUH1Hpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUH1Hpg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 03:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266683AbUH1Hpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 03:45:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17425 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263962AbUH1Hpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 03:45:34 -0400
Date: Sat, 28 Aug 2004 08:45:29 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, perex@suse.de
Subject: Re: ALSA update broke Sparc
Message-ID: <20040828084529.C15347@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, perex@suse.de
References: <20040827183646.1da2befc.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040827183646.1da2befc.davem@davemloft.net>; from davem@davemloft.net on Fri, Aug 27, 2004 at 06:36:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 06:36:46PM -0700, David S. Miller wrote:
> Can I make a small formal request of the ALSA folks?  Can you
> at least setup a cross-compiler to make sure your ALSA merges
> don't explode on sparc64?  As it stands, 1 out of every 2 ALSA
> merges breaks the build on that platform.

This is only one such small case.  There's also the case of mmaping
DMA buffers into userspace...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
