Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbVIZTaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbVIZTaS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 15:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbVIZTaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 15:30:18 -0400
Received: from imap.gmx.net ([213.165.64.20]:727 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751379AbVIZTaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 15:30:16 -0400
X-Authenticated: #20450766
Date: Mon, 26 Sep 2005 21:29:31 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Peter Osterlund <petero2@telia.com>
cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [2.6.13] pktcdvd: IO-errors
In-Reply-To: <m34q873ccc.fsf@telia.com>
Message-ID: <Pine.LNX.4.60.0509262122450.4031@poirot.grange>
References: <Pine.LNX.4.60.0509242057001.4899@poirot.grange> <m3slvtzf72.fsf@telia.com>
 <Pine.LNX.4.60.0509252026290.3089@poirot.grange> <m34q873ccc.fsf@telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005, Peter Osterlund wrote:

> Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:
> 
> > Besides, it works under 2.6.12-rc5...
> 
> What gcc versions were used when compiling the kernels? (Boot both
> kernels, run "cat /proc/version" to find out.)

Well, they are somewhat different:

Linux version 2.6.12-rc5 (lyakh@poirot.grange) (gcc version 3.3.4 (Debian 
1:3.3.4-13)) #1 Sun May 29 22:53:31 CEST 2005

Linux version 2.6.13.1 (lyakh@poirot.grange) (gcc version 3.3.5 (Debian 
1:3.3.5-13)) #1 Sat Sep 17 11:57:51 CEST 2005

... No gcc-4.0, but still - 3.3.4 and 3.3.5... I could try recompiling 
2.6.12 with 3.3.5... Do you REALLY believe it could be the reason?

> I just discovered that the driver doesn't work correctly on my laptop
> if I use "gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)" from Fedora
> Core 4. "pktsetup 0 /dev/hdc ; cat /proc/driver/pktcdvd/pktcdvd0"
> OOPSes. If I use gcc32 it does seem to work though.

Doesn't Oops for me under 2.6.13.1 compiled with 3.3.5, that's where I get 
errors.

Thanks
Guennadi
---
Guennadi Liakhovetski
