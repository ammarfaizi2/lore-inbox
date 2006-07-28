Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752044AbWG1REF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbWG1REF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbWG1REF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:04:05 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:19939 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1752044AbWG1REE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:04:04 -0400
Date: Fri, 28 Jul 2006 19:03:10 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Robert Hancock <hancockr@shaw.ca>
cc: ravibt@gmail.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BIOS detects 4 GB RAM, but kernel does not
In-Reply-To: <44C79E56.2040603@shaw.ca>
Message-ID: <Pine.LNX.4.61.0607281902560.4972@yvahk01.tjqt.qr>
References: <1153931278.034068.54630@h48g2000cwc.googlegroups.com>
 <44C79E56.2040603@shaw.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Essentially I don't think there is much you can do about this on this board.
> The memory space starting at around 3.2GB is being used by the memory-mapped IO
> regions for the PCI and PCI Express devices and motherboard resources and
> therefore "covers up" the RAM in that part of the address space. The solution
> to this is for the system to remap the affected memory above the 4GB mark,
> which is possible with Athlon 64/Opteron CPUs and on some of the Intel server
> chipsets. However, I don't think any Intel desktop chipsets support this for
> some unfathomable reason.

Maybe PAE can help?


Jan Engelhardt
-- 
