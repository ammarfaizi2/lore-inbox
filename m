Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265538AbUATOJQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 09:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265552AbUATOJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 09:09:16 -0500
Received: from mail.tammen.info ([62.225.14.106]:14087 "EHLO mail.tammen.de")
	by vger.kernel.org with ESMTP id S265538AbUATOJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 09:09:11 -0500
From: Heinz Ulrich Stille <hus@design-d.de>
Organization: design_d gmbh
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ALSA vs. OSS
Date: Tue, 20 Jan 2004 15:08:52 +0100
User-Agent: KMail/1.5.94
Cc: Mark Borgerding <mark@borgerding.net>
References: <1074532714.16759.4.camel@midux> <200401201046.24172.hus@design-d.de> <400D2AB2.7030400@borgerding.net>
In-Reply-To: <400D2AB2.7030400@borgerding.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200401201509.02098.hus@design-d.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 January 2004 14:18, Mark Borgerding wrote:
> If I may be so bold as to make a suggestion: Maybe the developer in
> charge of ALSA's e-mu driver could work with us poor unfortunates.

The first thing would be to get the latest alsa version (1.0.1) to work
with a 2.6 kernel (or wait for it to be integrated); so far I had no luck
either with the packaged 1.0.1 or the CVS version.

Loading the kernel version of the modules always fails with:
ALSA sound/pci/ac97/ac97_codec.c:1671: AC'97 0:0 does not respond - RESET
EMU10K1_Audigy: probe of 0000:02:04.0 failed with error -6

> Sound: SBLive Value

SB Live! Platinum; lspci says "Creative Labs SB Live! EMU10k1 (rev 07)"

> Redhat 7.3 (w/ piecemeal recompiles & upgrades)

Based somewhere around RedHat 8 or 9, but this should not matter, apart
perhaps from the compiler, which I compiled myself: gcc 3.3.1 (also tried
gcc 2.95.3) and binutils 2.14.

> Kernel: 2.6.1

2.6.0

> CPU: Athlon XP 2100+
> Mobo: ASUS (I think it's A7V333. I can confirm this later.)

Dual Athlon XP 2000+ on Tyan Tiger MPX

-- 
Heinz Ulrich Stille / Tel.: +49-541-9400463 / Fax: +49-541-9400450
design_d gmbh / Lortzingstr. 2 / 49074 Osnabrück / www.design-d.de
