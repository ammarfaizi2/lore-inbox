Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277556AbRJKASG>; Wed, 10 Oct 2001 20:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277552AbRJKAR4>; Wed, 10 Oct 2001 20:17:56 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:48043
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S277559AbRJKARi>; Wed, 10 Oct 2001 20:17:38 -0400
Date: Wed, 10 Oct 2001 17:17:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Mike Borrelli <mike@nerv-9.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.10-ac10 ppc fixes
Message-ID: <20011010171728.A10830@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <Pine.LNX.4.21.0110101146220.10995-100000@asuka.nerv-9.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0110101146220.10995-100000@asuka.nerv-9.net>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 11:51:29AM -0700, Mike Borrelli wrote:

> This patch contains the changes required to get the latest (ATM) version
> of Alan's tree to compile on the powerpc.
> 
> The patch is located at: http://www.nerv-9.net/ as either
> patch-2.4.10-ac10mb.bz2 or patch-2.4.10-ac10mb.gz

Erm, when did they break?  Paul sent in (and I swear I saw 'em accepted)
patches to -ac6 or 7.  This is just updating to the stuff in 2.4.11
which will make it's way to Alan shortly (esp if the next ext3 is vs
-ac10).

In fact, I see some regressions even:
linux/arch/ppc/kernel/setup.c really should be bogus (and I hope this
isn't in Linus tree...)
linux/drivers/char/serial.c should _never_ make it out of the ppc tree
as it's a hack that can die shortly.  And ncr885 is dead.

Alan, please don't apply this.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
