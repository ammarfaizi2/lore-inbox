Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbTLCRGw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 12:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbTLCRGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 12:06:52 -0500
Received: from relay.pair.com ([209.68.1.20]:60933 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S265098AbTLCRGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 12:06:51 -0500
X-pair-Authenticated: 68.42.66.6
Subject: Re: emu10k1 under kernel 2.6?
From: Daniel Gryniewicz <dang@fprintf.net>
To: Heinz Ulrich Stille <hus@design-d.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200312031226.08858.hus@design-d.de>
References: <200312021017.07936.hus@design-d.de>
	 <1070387001.3fcccf39b1f70@horde.sandall.us>
	 <200312031226.08858.hus@design-d.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1070471203.4071.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 03 Dec 2003 12:06:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-03 at 06:25, Heinz Ulrich Stille wrote:
> On Tuesday 02 December 2003 18:43, Eric Sandall wrote:
> > Quoting Heinz Ulrich Stille <hus@design-d.de>:
> > > ALSA sound/pci/ac97/ac97_codec.c:1671: AC'97 0:0 does not respond - RESET
> > > EMU10K1_Audigy: probe of 0000:02:06.0 failed with error -6
> [...]
> > You have to setup your sound drivers in the kernel now (either OSS or ALSA,
> > the latter is preferred). I have my SB Live! working on all of the 2.6
> > kernels (including the -mm patchsets).
> 
> I'm using ALSA in 2.4 as well as in 2.6, but where can I find a setup?
> 
> > Also, a quick Google search[0] returns at least one page (it shows 10
> > pages) of usefull information.
> 
> Hm, looks like I tried the wrong set of words. Even now I did not find
> anything definitive, but I got the impression that IRQ sharing does not
> work anymore (I never checked that - I've got exactly two cards on my
> board, graphics and sound and guess what - I seem to have picked the one
> PCI slot that shares it's IRQ with AGP...).
> Could that really be the problem? It does work with 2.4.
> 
> Btw, the system is SMP, a Tyan Tiger MPX with two Athlon XPs.

I have a tyan tiger MP with two Athlon MPs, and my emu10k1 does not work
with ALSA on 2.4.  I haven't looked into it closely, as I don't really
use sound on this box, but maybe it's a SMP thing?  Probably not the
right list for this, but it's a datapoint.
-- 
Daniel Gryniewicz <dang@fprintf.net>
