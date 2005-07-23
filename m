Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbVGWCrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVGWCrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 22:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVGWCrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 22:47:35 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:30456 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262317AbVGWCrc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 22:47:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GVq2Z8DO3slMLQtuE2T3aTnnqGsCfehcLybTrf1Dq3C/K7iI9LDNek6rQD4ddkQ4AGT13joRlUXjUchbMLRUK17LVB+Gd73ZeczYRDf2q2IrzI1APv5/KKI3RZnoGS4ty9fAcUFT2h/vZL1ETBeFIVPubEHHFxb/bkIh1WUv0kI=
Message-ID: <58cb370e0507221947c1b88a4@mail.gmail.com>
Date: Fri, 22 Jul 2005 22:47:30 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: mdew <some.nzguy@gmail.com>
Subject: Re: HPT370 errors under 2.6.13-rc3-mm1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1c1c863605072219283716a131@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1c1c863605072219283716a131@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Does vanilla kernel 2.6.12 work for you?
It doesn't contain hpt366 driver update.

Bartlomiej

On 7/22/05, mdew <some.nzguy@gmail.com> wrote:
> I'm unable to mount an ext2 drive using the hpt370A raid card.
> 
> upon mounting the drive, dmesg will spew these errors..I've tried
> different cables and drive is fine.
> 
> Jul 23 01:30:11 localhost kernel: hdf: dma_timer_expiry: dma status == 0x41
> Jul 23 01:30:21 localhost kernel: hdf: DMA timeout error
> Jul 23 01:30:21 localhost kernel: hdf: dma timeout error: status=0x25
> { DeviceFault CorrectedError Error }
> Jul 23 01:30:21 localhost kernel: hdf: dma timeout error: error=0x25 {
> DriveStatusError AddrMarkNotFound }, LBAsect=8830589412645,
> high=526344, low=2434341, sector=390715711
> Jul 23 01:30:21 localhost kernel: ide: failed opcode was: unknown
> Jul 23 01:30:21 localhost kernel: hdf: DMA disabled
> Jul 23 01:30:21 localhost kernel: ide2: reset: master: error (0x0a?)
> Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf,
> sector 390715711
> Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf,
> sector 390715712
> [...]
