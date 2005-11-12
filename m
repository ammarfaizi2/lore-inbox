Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbVKLW17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbVKLW17 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 17:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbVKLW17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 17:27:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:2777 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964802AbVKLW16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 17:27:58 -0500
Subject: Re: Linuv 2.6.15-rc1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Michael Buesch <mbuesch@freenet.de>, Paul Mackerras <paulus@samba.org>,
       linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	 <200511122145.38409.mbuesch@freenet.de>
	 <Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
Content-Type: text/plain; charset=utf-8
Date: Sun, 13 Nov 2005 09:24:14 +1100
Message-Id: <1131834254.7406.43.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-12 at 13:00 -0800, Linus Torvalds wrote:
> 
> On Sat, 12 Nov 2005, Michael Buesch wrote:
> > 
> > Latest GIT tree does not boot on my G4 PowerBook.
> 
> What happens if you do
> 
> 	make ARCH=powerpc
> 
> and build everything that way (including the "config" phase)?
> 
> So far ppc32 is still a valid architecture, and your config file makes it 
> clear that you've used that. But I suspect most of the active testing has 
> been done with the "powerpc" architecture compiled for 32-bit.
> 
> That said, the ppc32 tree should still work. BenH? Paul?

Ìt should still work. I'm running -rc1 with "powerpc" on mine so that at
least works, it's possible that we broke "ppc", I'll have a look and
send a fix.

Ben.


