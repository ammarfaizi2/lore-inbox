Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272885AbTHKSVu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272898AbTHKSVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:21:21 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:48516 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S272885AbTHKSUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:20:20 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 11 Aug 2003 20:31:32 +0200
From: Gerd Knorr <kraxel@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Christoph Bartelmus <columbus@hit.handshake.de>,
       lirc-list@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030811183132.GB17777@bytesex.org>
References: <1059820741.3116.24.camel@laurelin> <20030807214311.GC211@elf.ucw.cz> <1060334463.5037.13.camel@defiant.flameeyes> <20030808231733.GF389@elf.ucw.cz> <8rZ2nqa1z9B@hit-columbus.hit.handshake.de> <20030811124744.GB1733@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811124744.GB1733@elf.ucw.cz>
X-GPG-Fingerprint: 79C4 EE94 CC44 6DD4 58C6  3088 DBB7 EC73 8750 D2C4  [1024D/8750D2C4]
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I converted lirc_gpio into input/ layer (and killed support for
> hardware I do not have; sorry but it was essential to keep code
> small). Ported driver looks like this; I believe it looks better than
> old code. Patch is here.

And IMHO it will be even better if it is linked directly into the bttv
driver and bttv itself registers as input device.  All the complicated
probing using the functions exported by bttv will go away.  The whole
construct is only needed because lirc isn't part of the standard
kernel ...

  Gerd

