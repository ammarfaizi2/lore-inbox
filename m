Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262363AbSKCWNi>; Sun, 3 Nov 2002 17:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262450AbSKCWNi>; Sun, 3 Nov 2002 17:13:38 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:62094 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262363AbSKCWNh>; Sun, 3 Nov 2002 17:13:37 -0500
Subject: Re: swsusp: don't eat ide disks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: benh@kernel.crashing.org, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021103220904.GE28704@atrey.karlin.mff.cuni.cz>
References: <200211022006.gA2K6XW08545@devserv.devel.redhat.com>
	<20021103145735.14872@smtp.wanadoo.fr>
	<1036340733.29642.41.camel@irongate.swansea.linux.org.uk>
	<20021103201251.GE27271@elf.ucw.cz>
	<1036359207.30629.31.camel@irongate.swansea.linux.org.uk> 
	<20021103220904.GE28704@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 22:41:24 +0000
Message-Id: <1036363284.30679.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 22:09, Pavel Machek wrote:
> You are probably right that for ide disk quiescing a queue is enough,
> but nothing prevents block device to do some DMA just for fun. Also I
> want to spindown on suspend (andre wanted that, to flush caches), so I
> guess that the patch is quite good as-is....

That will get done by the power down part of the process as its needed
in both cases


