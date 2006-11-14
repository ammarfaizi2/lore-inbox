Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966396AbWKNVwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966396AbWKNVwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966397AbWKNVwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:52:50 -0500
Received: from cadalboia.ferrara.linux.it ([195.110.122.101]:46030 "EHLO
	cadalboia.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S966396AbWKNVwt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:52:49 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Andrew Morton <akpm@osdl.org>
Subject: Re: SATA ICH5 not detected at boot, mm-kernels
Date: Tue, 14 Nov 2006 22:52:42 +0100
User-Agent: KMail/1.9.5
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>
References: <200611051536.35333.cova@ferrara.linux.it> <200611131017.51676.cova@ferrara.linux.it> <20061113132904.52e6fde7.akpm@osdl.org>
In-Reply-To: <20061113132904.52e6fde7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611142252.42623.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 22:29, lunedì 13 novembre 2006, Andrew Morton ha scritto:

>
> In an earlier email, Tejun said:
> > >> Nov  5 13:26:37 kefk ata: 0x170 IDE port busy
> > >> Nov  5 13:26:37 kefk ata: conflict with ide1
> > >
> > > hm.  What does that mean?
> >
> > It means that IDE layer claimed the port.  It can be overridden by
> > combined_mode kernel parameter.
>
> Did you try that?

Uh, well, to be honest, no..or better: not yet :)

anyway, applying this patch: http://lkml.org/lkml/2006/11/13/150
tghe problem disappeared and 2.6.19-rc5-mm1 booted just fine, seeing all 
ata_piix devices.
