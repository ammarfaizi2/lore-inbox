Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267508AbUBTEDM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 23:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267502AbUBTEDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 23:03:12 -0500
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:18048
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id S267508AbUBTEDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 23:03:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16437.34558.298388.89482@panda.mostang.com>
Date: Thu, 19 Feb 2004 20:03:10 -0800
To: Bill Davidsen <davidsen@tmr.com>
Cc: David Mosberger-Tang <David.Mosberger@acm.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Intel x86-64 support merge
In-Reply-To: <40353382.8010505@tmr.com>
References: <1qK5k-7g2-67@gated-at.bofh.it>
	<1qK5k-7g2-69@gated-at.bofh.it>
	<1qK5k-7g2-71@gated-at.bofh.it>
	<1qK5k-7g2-73@gated-at.bofh.it>
	<1qK5k-7g2-65@gated-at.bofh.it>
	<40353382.8010505@tmr.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: David.Mosberger@acm.org
X-URL: http://www.mostang.com/~davidm/
From: davidm@mostang.com (David Mosberger-Tang)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 19 Feb 2004 17:06:58 -0500, Bill Davidsen <davidsen@tmr.com> said:

  Bill> David Mosberger-Tang wrote:
  >>>>>>> On Thu, 19 Feb 2004 00:40:24 +0100, Arjan van de Ven
  >>>>>>> <arjan@fenrus.demon.nl> said:
  >>
  Arjan> On Wed, 2004-02-18 at 23:57, H. Peter Anvin wrote:
  >> >> Because they were caught by surprise and just hacked the chips
  >> >> they had in the pipeline, presumably.

  Arjan> fair enough; I hope this means the next generation has this
  Arjan> wart fixed...
  >>  I wouldn't hold my breath.  My impression was that the Intel
  >> chipset folks don't want I/O MMU because (a) Windows doesn't need
  >> it and (b) real machines use (close-to-)64-bit-capable hardware.

  Bill> Doesn't need it? Does that mean the Win64 uses bounce buffers
  Bill> for everything? Or am I totally misreading this?

Remember: I'm just the messenger here...

I have no idea what Win64 does, but obviously bounce buffering is only
an issue for devices that can't address all physical memory.  These
days, even relatively low-end machines have devices that can address
"more than enough" physical memory (I'm not sure exactly what the DMA
limit of, say, a Kenai32 e1000 card is, but it's a lot more than 4GB).

	--david
