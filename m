Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267495AbUIATtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267495AbUIATtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 15:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267475AbUIATrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 15:47:55 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:18908 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S267452AbUIATqc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 15:46:32 -0400
Subject: Integrated ethernet on SiS chipset NOW does work
From: Jean Francois Martinez <jfm512@free.fr>
To: Daniele Venzano <webvenza@libero.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040804083208.GE18272@gateway.milesteg.arr>
References: <1089480939.2779.22.camel@agnes>
	 <Pine.LNX.4.53.0407102141560.5590@chaos> <1089538014.4690.32.camel@agnes>
	 <20040711101608.GB10738@picchio.gall.it> <1091130156.2912.17.camel@agnes>
	 <20040804083208.GE18272@gateway.milesteg.arr>
Content-Type: text/plain; charset=utf-8
Message-Id: <1094067991.5652.13.camel@agnes>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 21:46:31 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A month ago you wrote:

Le mer 04/08/2004 à 10:32, Daniele Venzano a écrit :
> On Thu, Jul 29, 2004 at 09:42:36PM +0200, Jean Francois Martinez wrote:
> > Here is the interesting part of his dmesg, after reloading the
> > sis900 driver.  We can see that the card
> > indentifies a VIA transceiver at address 1 but instead uses the 
> > (inexistent) one at address 31.
> 
> > eth0: VIA 6103 PHY transceiver found at address 1.
> ...
> > eth0: Unknown PHY transceiver found at address 31.
> > eth0: Using transceiver found at address 31 as default
> > eth0: SiS 900 PCI Fast Ethernet at 0xe800, IRQ 11, 00:0c:76:68:a9:89.
> 
> This behaviuor should be corrected in tha latest kernels (mm or bk) by
> the patches available here:
> http://teg.homeunix.org/sis900.html
> 
> If all fails this patch should work just fine:
> http://teg.homeunix.org/download/kpatches/sis900-list-phy-ids.diff
> But is just for that particular case.
> 

I applied the patch to the sis900 driver in 2.4.21 (Suse).  This fixed
the problem and the integrated ethernet now works.  Thank you.

Sorry for the delay.

				JFM





