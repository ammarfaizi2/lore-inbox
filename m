Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265369AbUASQgN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 11:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUASQgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 11:36:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:7312 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265369AbUASQgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 11:36:09 -0500
Date: Mon, 19 Jan 2004 08:32:10 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org, lbudai@ms.sapientia.ro
Subject: Re: No module sym53c8xx found for kernel 2.6.1
Message-Id: <20040119083210.213b33da.rddunlap@osdl.org>
In-Reply-To: <20040119125807.GA15292@merlin.emma.line.org>
References: <400BC220.6070909@ms.sapientia.ro>
	<20040119125807.GA15292@merlin.emma.line.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004 13:58:07 +0100 Matthias Andree <matthias.andree@gmx.de> wrote:

| On Mon, 19 Jan 2004, Budai Laszlo wrote:
| 
| > Hi there,
| > 
| > I try to compile the 2.6.1 kernel downloaded from www.kernel.org.
| > 
| > Everything seems ok until I give the "make install" command when I got 
| > the following message:
| > 
| > [root@fuji linux-2.6.1]# make install
| > make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
| >   CHK     include/linux/compile.h
| > Kernel: arch/i386/boot/bzImage is ready
| > sh /root/linux-2.6.1/arch/i386/boot/install.sh 2.6.1 
| > arch/i386/boot/bzImage System.map ""
| > No module sym53c8xx found for kernel 2.6.1
| > mkinitrd failed
| > make[1]: *** [install] Error 1
| > make: *** [install] Error 2
| > 
| > 
| > The module sym53c8xx is in the linux-2.6.1/drivers/scsi/sym53c8xx_2 
| > directory but it seems that there is some problem with it.
| 
| Is your mkinitrd script ready to install 2.6? Check
| Documentation/Changes for any necessary tool updates.

and the sym53c8xx driver was removed IIRC.
Use sym53c8xx_2 instead.

--
~Randy
Everything is relative.
