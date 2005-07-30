Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263168AbVG3Uwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263168AbVG3Uwo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbVG3Uw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:52:28 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:4281 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S263175AbVG3Uvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:51:31 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: revert yenta free_irq on suspend
Date: Sat, 30 Jul 2005 22:49:54 +0200
User-Agent: KMail/1.8.1
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507302249.55409.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 30 of July 2005 21:10, Hugh Dickins wrote:
> Please revert the yenta free_irq on suspend patch (below)
> which went into 2.6.13-rc4 after 2.6.13-rc3-git9.
> 
> Sorry Daniel, you may have a box on which resume doesn't work without
> it, but on my laptop APM resume from RAM now fails to work because of
> it - locks up solid.

Well, the patch is needed on other boxes too (eg. mine :-)) due to the recent
changes in ACPI.

Could you please send the /proc/interrupts from your box?

Rafael
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
