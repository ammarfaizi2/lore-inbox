Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbUBHSdO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 13:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbUBHScw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 13:32:52 -0500
Received: from dsl-213-023-007-056.arcor-ip.net ([213.23.7.56]:63400 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S264132AbUBHSct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 13:32:49 -0500
Date: Sun, 8 Feb 2004 19:32:10 +0100
From: Georg C F Greve <greve@gnuhh.org>
Message-Id: <200402081832.i18IWAPg001599@brain.gnuhh.org>
To: linux-kernel@vger.kernel.org
CC: Ari Pollak <ajp@aripollak.com>, greve@gnuhh.org
Subject: Re: [PROBLEM] 2.6.3-rc1: still no suspend/resume on Centrino notebook
In-Reply-To: <c05slq$e1r$1@sea.gmane.org>
References: <c05slq$e1r$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > The Thinkpad T40 and T41 at least; they suspend & resume properly,
 > but there are still interrupt-losing problems when resuming, which
 > is a totally separate issue. I believe they both use the 8255PM
 > chipset:

 > 00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O
 > Controller (rev 03)

Thanks.

AFAIK, there are essentially three "Centrino" chipsets
       Intel 855GM [1]
       Intel 855PM [2]
       Intel 855GME [3].

So 855PM based laptops seem to work, whereas 855GM based laptops
apparently don't. So it would be logical to assume it is the
difference between these two that causes the problems.

Unfortunately I'm not sure whether that brings us any further as it
seems that it is the integrated graphics stuff that makes the
difference -- or is there more?

Regards,
Georg


[1] http://www.intel.com/design/chipsets/mobile/855gm.htm?iid=dev_chips855fam+855gm&
[2] http://www.intel.com/design/chipsets/mobile/855pm.htm?iid=dev_chips855fam+855pm&
[3] http://www.intel.com/design/chipsets/mobile/855GME.htm?iid=dev_chips855fam+855gme&
