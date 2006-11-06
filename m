Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753066AbWKFNSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbWKFNSM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 08:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753067AbWKFNSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 08:18:12 -0500
Received: from cadalboia.ferrara.linux.it ([195.110.122.101]:11910 "EHLO
	cadalboia.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S1753065AbWKFNSL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 08:18:11 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA ICH5 not detected at boot, mm-kernels
Date: Mon, 6 Nov 2006 14:18:06 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>
References: <200611051536.35333.cova@ferrara.linux.it> <20061105161725.1a326135.akpm@osdl.org> <454F2E0F.3010804@gmail.com>
In-Reply-To: <454F2E0F.3010804@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611061418.07470.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 13:43, lunedì 6 novembre 2006, Tejun Heo ha scritto:

> >> (320073 MB)
> >> Nov  5 13:26:37 kefk sdc: Write Protect is off
> >
> > And why doesn't -mm report the same conflict?  I assume the .config is
> > the same?
>
> Also, please post full dmesg of both kernels.

Sure; now I'm far from the afflicted machine, but I'll post dmesg and .config 
for all kernels (I've to use serial console debug for the non working one: 
the non working drive,unfortunately, is needed to have machine up and 
running  :) .). 
I'm pretty sure that the configs between 2.6.18-mm3 and 2.6.19-rcXmmY are the 
same; I've compiled newer kernel using make oldconfig based on 
working .config. But in the last days I've tweaked the configs trying to make 
it work, so I'll start a fresh build to avoid any doubt. I'll do this as soon 
as I'm again near the machine (I've no remote maintenance facility on this 
machine)

-- 
Fabio "Cova" Coatti    http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
