Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264158AbTDPA2h (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 20:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264170AbTDPA2h 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 20:28:37 -0400
Received: from golf.rb.xcalibre.co.uk ([217.8.240.16]:2319 "EHLO
	golf.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S264158AbTDPA2g (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 20:28:36 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair Strachan <alistair@devzero.co.uk>
To: Udo Hoerhold <maillists@goodontoast.com>
Subject: Re: SoundBlaster Live! with kernel 2.5.x
Date: Wed, 16 Apr 2003 01:40:23 +0100
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200304160140.23873.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Udo Hoerhold wrote:
> Hello,
> 
> I've been running Debian woody with 2.4.20 kernel.  I'm trying to switch
> to
> 2.5.  I built 2.5.67 with emu10k driver in the kernel (same as I had with
> 2.4.20), but I get only a lot of popping sounds from the sound card.  I
> also
> tried 2.5.50 and 2.5.67-mm3, with the same result.  I googled for emu10k
> and soundblaster with 2.5, but I haven't seen anyone else with the same
> problem. Does anyone know what this problem is?

Are you using the OSS or ALSA driver?

[alistair] 01:38am [~] dmesg | egrep -e EMU10K1
Creative EMU10K1 PCI Audio Driver, version 0.20, 15:35:08 Apr 14 2003
emu10k1: EMU10K1 rev 7 model 0x8026 found, IO at 0xe400-0xe41f, IRQ 12

The soundcard is working perfectly with the OSS driver, for me, in 2.5.67-mm1. 
I'm running the latest version of the emu-tools. Please try matching this 
configuration.

Cheers,
Alistair.

