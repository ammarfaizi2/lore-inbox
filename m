Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933065AbWKMVaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933065AbWKMVaQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933060AbWKMVaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:30:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52683 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933065AbWKMVaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:30:13 -0500
Date: Mon, 13 Nov 2006 13:29:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA ICH5 not detected at boot, mm-kernels
Message-Id: <20061113132904.52e6fde7.akpm@osdl.org>
In-Reply-To: <200611131017.51676.cova@ferrara.linux.it>
References: <200611051536.35333.cova@ferrara.linux.it>
	<454F2E0F.3010804@gmail.com>
	<200611061418.07470.cova@ferrara.linux.it>
	<200611131017.51676.cova@ferrara.linux.it>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006 10:17:38 +0100
Fabio Coatti <cova@ferrara.linux.it> wrote:

> Alle 14:18, luned__ 6 novembre 2006, Fabio Coatti ha scritto:
> > Alle 13:43, luned__ 6 novembre 2006, Tejun Heo ha scritto:
> > > >> (320073 MB)
> > > >> Nov  5 13:26:37 kefk sdc: Write Protect is off
> > > >
> > > > And why doesn't -mm report the same conflict?  I assume the .config is
> > > > the same?
> > >
> > > Also, please post full dmesg of both kernels.
> 
> I've finally saved the dmesg from 2.6.19-rc5-mm1, the one that hangs at boot, 
> not detecting two sata disks:

Thanks.

In an earlier email, Tejun said:

> >> Nov  5 13:26:37 kefk ata: 0x170 IDE port busy
> >> Nov  5 13:26:37 kefk ata: conflict with ide1
> > 
> > hm.  What does that mean?
> 
> It means that IDE layer claimed the port.  It can be overridden by 
> combined_mode kernel parameter.
> 

Did you try that?
