Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbUASM6R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 07:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUASM6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 07:58:17 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:30922 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264879AbUASM6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 07:58:14 -0500
Date: Mon, 19 Jan 2004 13:58:07 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: No module sym53c8xx found for kernel 2.6.1
Message-ID: <20040119125807.GA15292@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <400BC220.6070909@ms.sapientia.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400BC220.6070909@ms.sapientia.ro>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004, Budai Laszlo wrote:

> Hi there,
> 
> I try to compile the 2.6.1 kernel downloaded from www.kernel.org.
> 
> Everything seems ok until I give the "make install" command when I got 
> the following message:
> 
> [root@fuji linux-2.6.1]# make install
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
> Kernel: arch/i386/boot/bzImage is ready
> sh /root/linux-2.6.1/arch/i386/boot/install.sh 2.6.1 
> arch/i386/boot/bzImage System.map ""
> No module sym53c8xx found for kernel 2.6.1
> mkinitrd failed
> make[1]: *** [install] Error 1
> make: *** [install] Error 2
> 
> 
> The module sym53c8xx is in the linux-2.6.1/drivers/scsi/sym53c8xx_2 
> directory but it seems that there is some problem with it.

Is your mkinitrd script ready to install 2.6? Check
Documentation/Changes for any necessary tool updates.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
