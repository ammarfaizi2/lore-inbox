Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUEFP4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUEFP4i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 11:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUEFP4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 11:56:38 -0400
Received: from svxf1a001p.gps.infracom.it ([217.12.180.1]:14241 "EHLO
	smtp1.infracom.it") by vger.kernel.org with ESMTP id S262356AbUEFP4h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 11:56:37 -0400
Date: Thu, 6 May 2004 17:56:30 +0200
From: Antonio Dolcetta <adolcetta@infracom.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2
Message-Id: <20040506175630.6adb6016@simbad>
In-Reply-To: <20040506081258.569d696e.akpm@osdl.org>
References: <20040505013135.7689e38d.akpm@osdl.org>
	<20040506165304.6376fed1@simbad>
	<20040506081258.569d696e.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Ff>cp|(|}BIY<{%+OIxjt,E5:W.\OC~.w%;\l"M8TJ'mks=0a"smDo=58<y'P};g83XQQO,
 T>etiyr(H\tfzfEtPT7:O9`&~[pgFj=S]})*<s?wuHOC>-[(4yfk]aI$F424s%sDWv1jo|q^#pG/:.
 <'mSIw`%!FD;;ksFkJ|m.^K7#r(@q\/Bj)PU\,RA27UMCI<GgEm*sTjR^a/~ppf/S67Hx%1DEJ#[g^
 tn1_Rw.p~Xdc1Z?Gv:kfI-@bnM|jBj#RZvrFPBiKT%&#aR/qYpAq?Wdfq7{(z5FCcMd48zoU"9ma^@
 Vd?A8
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2004 08:12:58 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Antonio Dolcetta <adolcetta@infracom.it> wrote:
> >
> > something has broken the b44 module,
> >  modprobe b44 fails with:
> >  FATAL: Error inserting b44 (/lib/modules/2.6.6-rc3-mm2/kernel/drivers/net/b44.ko): Unknown symbol in module, or unknown parameter (see dmesg)
> > 
> >  dmesg contains the line:
> >  b44: Unknown symbol generic_mii_ioctl
> 
> Please config that your .config does not set CONFIG_MII?
> 
> 

I enabled the Media Independent Interface and it works perfectly
Sorry for the noise
 

	Antonio
