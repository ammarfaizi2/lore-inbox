Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbTLCL0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 06:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbTLCL0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 06:26:19 -0500
Received: from mail.tammen.info ([62.225.14.106]:23822 "EHLO mail.tammen.de")
	by vger.kernel.org with ESMTP id S264550AbTLCL0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 06:26:16 -0500
From: Heinz Ulrich Stille <hus@design-d.de>
Organization: design_d gmbh
To: linux-kernel@vger.kernel.org
Subject: Re: emu10k1 under kernel 2.6?
Date: Wed, 3 Dec 2003 12:25:59 +0100
User-Agent: KMail/1.5.93
References: <200312021017.07936.hus@design-d.de> <1070387001.3fcccf39b1f70@horde.sandall.us>
In-Reply-To: <1070387001.3fcccf39b1f70@horde.sandall.us>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200312031226.08858.hus@design-d.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 December 2003 18:43, Eric Sandall wrote:
> Quoting Heinz Ulrich Stille <hus@design-d.de>:
> > ALSA sound/pci/ac97/ac97_codec.c:1671: AC'97 0:0 does not respond - RESET
> > EMU10K1_Audigy: probe of 0000:02:06.0 failed with error -6
[...]
> You have to setup your sound drivers in the kernel now (either OSS or ALSA,
> the latter is preferred). I have my SB Live! working on all of the 2.6
> kernels (including the -mm patchsets).

I'm using ALSA in 2.4 as well as in 2.6, but where can I find a setup?

> Also, a quick Google search[0] returns at least one page (it shows 10
> pages) of usefull information.

Hm, looks like I tried the wrong set of words. Even now I did not find
anything definitive, but I got the impression that IRQ sharing does not
work anymore (I never checked that - I've got exactly two cards on my
board, graphics and sound and guess what - I seem to have picked the one
PCI slot that shares it's IRQ with AGP...).
Could that really be the problem? It does work with 2.4.

Btw, the system is SMP, a Tyan Tiger MPX with two Athlon XPs.

MfG, Ulrich

-- 
Heinz Ulrich Stille / Tel.: +49-541-9400463 / Fax: +49-541-9400450
design_d gmbh / Lortzingstr. 2 / 49074 Osnabrück / www.design-d.de
