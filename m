Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVGWLuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVGWLuq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 07:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVGWLuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 07:50:46 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:59739 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261298AbVGWLuo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 07:50:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lu+jepc9ZfQDoYB8ta4UQYE0dtSvf+l6qrT3FNlAYAxHHhSv4QBgymVDkqahiyXcSUv7SWgttq6GnbgxQ5VoE0qzuOrBHOR9g6LPm1GxvtL0nNGZz9aWUSVgwiXk60moj+E8vlNpYskX+6mKi+QAWJYzbff0EYtLuEiITBl7Mr4=
Message-ID: <1c1c863605072304502cc25424@mail.gmail.com>
Date: Sat, 23 Jul 2005 23:50:43 +1200
From: mdew <some.nzguy@gmail.com>
Reply-To: mdew <some.nzguy@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: HPT370 errors under 2.6.13-rc3-mm1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e0507221947c1b88a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1c1c863605072219283716a131@mail.gmail.com>
	 <58cb370e0507221947c1b88a4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

looks like 2.6.12 does the same sort of thing..


On 7/23/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> Hi,
> 
> Does vanilla kernel 2.6.12 work for you?
> It doesn't contain hpt366 driver update.
> 
> Bartlomiej
> 
> On 7/22/05, mdew <some.nzguy@gmail.com> wrote:
> > I'm unable to mount an ext2 drive using the hpt370A raid card.
> >
> > upon mounting the drive, dmesg will spew these errors..I've tried
> > different cables and drive is fine.
> >
> > Jul 23 01:30:11 localhost kernel: hdf: dma_timer_expiry: dma status == 0x41
> > Jul 23 01:30:21 localhost kernel: hdf: DMA timeout error
> > Jul 23 01:30:21 localhost kernel: hdf: dma timeout error: status=0x25
> > { DeviceFault CorrectedError Error }
> > Jul 23 01:30:21 localhost kernel: hdf: dma timeout error: error=0x25 {
> > DriveStatusError AddrMarkNotFound }, LBAsect=8830589412645,
> > high=526344, low=2434341, sector=390715711
> > Jul 23 01:30:21 localhost kernel: ide: failed opcode was: unknown
> > Jul 23 01:30:21 localhost kernel: hdf: DMA disabled
> > Jul 23 01:30:21 localhost kernel: ide2: reset: master: error (0x0a?)
> > Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf,
> > sector 390715711
> > Jul 23 01:30:21 localhost kernel: end_request: I/O error, dev hdf,
> > sector 390715712
> > [...]
>
