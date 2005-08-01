Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVHAWDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVHAWDC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 18:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVHAWA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 18:00:59 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:19338 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261309AbVHAV7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:59:01 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] 2.6.13-rc4-git3: snd_intel8x0: handle irq_request failure on resume
Date: Tue, 2 Aug 2005 00:04:12 +0200
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200507311243.22375.rjw@sisk.pl> <s5hr7dd97kx.wl%tiwai@suse.de>
In-Reply-To: <s5hr7dd97kx.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508020004.12930.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 1 of August 2005 14:15, Takashi Iwai wrote:
> Hi Rafael,
> 
> At Sun, 31 Jul 2005 12:43:21 +0200,
> Rafael J. Wysocki wrote:
> > 
> > Hi,
> > 
> > This patch adds the handling of irq_request() failures during resume to
> > the snd_intel8x0 driver.
> > 
> > Please consider for applying,
> > Rafael
> 
> Not directly with the patch but I have a question about your first
> patch.  I found you changed from the second argument of
> snd_intel8x0_chip_init() from 0 to 1.  Is it intentional?

Yes.  My box hangs solid while executing snd_intel8x0_chip_init(0)
after requesting the IRQ in _resume().

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
