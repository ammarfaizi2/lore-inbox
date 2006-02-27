Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751596AbWB0Sxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbWB0Sxj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 13:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWB0Sxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 13:53:39 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:16019 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751596AbWB0Sxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 13:53:39 -0500
Date: Mon, 27 Feb 2006 19:53:35 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, col-pepper@piments.com,
       linux-kernel@vger.kernel.org
Subject: Re: o_sync in vfat driver
In-Reply-To: <Pine.LNX.4.61.0602270909460.4305@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0602271952060.13987@yvahk01.tjqt.qr>
References: <op.s5cj47sxj68xd1@mail.piments.com> <op.s5jpqvwhui3qek@mail.piments.com>
 <op.s5kxhyzgfx0war@mail.piments.com> <op.s5kx7xhfj68xd1@mail.piments.com>
 <op.s5kya3t0j68xd1@mail.piments.com> <op.s5ky2dbcj68xd1@mail.piments.com>
 <op.s5ky71nwj68xd1@mail.piments.com> <op.s5kzao2jj68xd1@mail.piments.com>
 <op.s5lq2hllj68xd1@mail.piments.com> <20060227132848.GA27601@csclub.uwaterloo.ca>
 <Pine.LNX.4.61.0602270909460.4305@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I really don't think one needs to worry about this! The flash-file-
>system designers know how to minimize wear and spread the wear
>throughout the device. It's not up to the file-systems to be
>concerned whatsoever!

Yes, the filesystem designers, JFFS and such. But most people unfortunately 
have to use something not-optimized-for-flash called VFAT to be able to 
read it on Win32 too. I would like to use UDF instead, but Windows seems to 
have a nogo with UDF on non-CDROMs.


Jan Engelhardt
-- 
