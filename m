Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbTJWKtY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 06:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTJWKtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 06:49:24 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:60851 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263415AbTJWKtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 06:49:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16279.45595.995992.419848@alkaid.it.uu.se>
Date: Thu, 23 Oct 2003 12:48:59 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Samuel Kvasnica <samuel.kvasnica@tuwien.ac.at>
Cc: linux-kernel@vger.kernel.org,
       Vitez Gabor <gabor@swszl.szkp.uni-miskolc.hu>,
       ivtv-devel@lists.sourceforge.net
Subject: Re: nforce2 random lockups - still no solution ?
In-Reply-To: <3F97AACB.2020609@tuwien.ac.at>
References: <3F95748E.8020202@tuwien.ac.at>
	<200310211113.00326.lkml@lpbproductions.com>
	<20031022085449.GA21393@swszl.szkp.uni-miskolc.hu>
	<3F96847C.4000506@tuwien.ac.at>
	<20031022133327.GA25283@swszl.szkp.uni-miskolc.hu>
	<3F97AACB.2020609@tuwien.ac.at>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Kvasnica writes:
 > Dear Gabor,
 > 
 > thantks a lot, indeed you are right ! I've been confused by some nforce 
 > FAQs where 'nolapic' option was recommended. In fact I did never check 
 > whether this option
 > really exists. Now, after recompiling the kernel the framegrabber works 
 > with uncompressed stream for almost 24h and it is rock-solid.
 > 
 > So, a workaround recommendation for all using ivtv driver on nforce2 
 > chipsets and kernels up to 2.4.22:
 > 
 > *** RECOMPILE YOUR KERNEL WITH LOCAL APIC DISABLED ***,
 > 
 > otherwise you'll experience very rare random lockups while watching the 
 > compressed stream and lockups within 10 minutes when watching the 
 > uncompressed
 > yuv stream.
 > 
 > What I'd like to know is whether this bug is AMD processor or chipset 
 > related.

Chipset and/or BIOS. AMD processors are known to work in other mobos.

You may try disabling just I/O-APIC or ACPI.
