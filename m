Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWI2IL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWI2IL4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWI2IL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:11:56 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:8877 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750735AbWI2ILy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:11:54 -0400
Date: Fri, 29 Sep 2006 10:10:59 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Stephan Wiebusch <stephanwib@t-online.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Initrd and ramdisk support
In-Reply-To: <200609282147.41671.stephanwib@t-online.de>
Message-ID: <Pine.LNX.4.61.0609291008170.20243@yvahk01.tjqt.qr>
References: <200609282147.41671.stephanwib@t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Unpacking initramfs...<0>Kernel panic - not syncing: bad gzip magic numbers
>Unpacking initramfs...<0>Kernel panic - not syncing: no cpio magic
>
>i luckily was able to determine the malefactor. There was the initrd support 
>built into the kernel while the ramdisk driver was just built as a module.
>
>Is it senseful to have the possibility to built the Initramfs/Initrd-support 
>without having the ramdisk driver forced to be integrated also?

I hardly see a point in using initrd support without ramdisk. Where would you
store the initrd on instead?


Jan Engelhardt
-- 
