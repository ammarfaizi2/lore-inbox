Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUFUHH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUFUHH5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 03:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUFUHH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 03:07:57 -0400
Received: from [195.255.196.126] ([195.255.196.126]:21478 "EHLO
	gw.compusonic.fi") by vger.kernel.org with ESMTP id S266136AbUFUHHq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 03:07:46 -0400
Date: Mon, 21 Jun 2004 10:07:44 +0300 (EEST)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: 4Front Technologies <dev@opensound.com>
Cc: David Lang <david.lang@digitalinsight.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
In-Reply-To: <40D636EA.7090704@opensound.com>
Message-ID: <Pine.LNX.4.58.0406210933470.26543@zeus.compusonic.fi>
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay><40D23701.1030302@opensound.com>
 <1087573691.19400.116.camel@winden.suse.de><40D32C1D.80309@opensound.com>
 <20040618190257.GN14915@schnapps.adilger.int><40D34CB2.10900@opensound.com><200406181940.i5IJeBDh032311@turing-police.cc.vt.edu><Pine.LNX.4.60.0406181326210.3688@dlang.diginsite.com>
 <Pine.LNX.4.58.0406191148570.30038@zeus.compusonic.fi>
 <Pine.LNX.4.60.0406201506360.6470@dlang.diginsite.com> <40D636EA.7090704@opensound.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004, 4Front Technologies wrote:

> There are loads of other very specific drivers for embedded systems that
> have no real applicability in the mainstream kernel like DSP boards, specialized
> encryption board drivers, military grade video capture/display devices. There
> are other things like PCI-Express "development" drivers that aren't stable and
> developers need a way to build them outside the kernel.
Everybody who still thinks it's going to be possible to have all possible
drivers in the single package should go to /lib/modules and execute

du -sk */kernel

In my test machine the directory sizes seem to be between 10M and 300M
depending on how the kernel was configured. For the Fedora Core 2 kernels
the sizes are around 25M. When Linux was young it was possible to have the
whole distribution fitted in that  amount of space.

What would the modules directory look like if the next generation devices
get included there too? Or if all the drivers for currently
unsupported defence, telecom, aviation, instrumentation and other special
purpose devices get included in the kernel source tree?

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
