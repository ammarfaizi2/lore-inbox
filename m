Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbUKGVug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbUKGVug (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 16:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbUKGVuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 16:50:35 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:10191 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261697AbUKGVuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 16:50:08 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm3: swsusp problems w/ ALSA driver, IRQs on AMD64
Date: Sun, 7 Nov 2004 22:48:54 +0100
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       alsa-devel@alsa-project.org
References: <200411062014.08202.rjw@sisk.pl> <20041107143858.GF1176@elf.ucw.cz>
In-Reply-To: <20041107143858.GF1176@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411072248.54627.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 of November 2004 15:38, Pavel Machek wrote:
> Hi!
> 
> > I'm having some troubles with swsusp on 2.6.10-rc1-mm3 (Athlon 64-based 
laptop 
> > w/ NForce3 chipset), although I don't think that swsusp itself is to
> > blame.
> 
> Did it work ok on other kernels?

On 2.6.10-rc1 it works even without pci=routeirq.  On 2.6.10-rc1-mm2 it did 
after I had used pci=routeirq, but I have tried it only once.

> Does it work when you rmmod intel8x0 before suspend?

Yes, it does, except for the pci=routeirq, which seems to be mandatory.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
