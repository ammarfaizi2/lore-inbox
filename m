Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276811AbRJCAe1>; Tue, 2 Oct 2001 20:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276812AbRJCAeQ>; Tue, 2 Oct 2001 20:34:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2309 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276811AbRJCAeC>; Tue, 2 Oct 2001 20:34:02 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: partition table read incorrectly
Date: 2 Oct 2001 17:34:16 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9pdme8$1gp$1@cesium.transmeta.com>
In-Reply-To: <20011002202934.G14582@wiggy.net> <E15oUUf-0005Xw-00@the-village.bc.nu> <20011002220053.H14582@wiggy.net> <20011002150820.N8954@turbolinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011002150820.N8954@turbolinux.com>
By author:    Andreas Dilger <adilger@turbolabs.com>
In newsgroup: linux.dev.kernel
> > 
> > If that bit is fine then how can it differ in opinion from fdisk?
> 
> What does the first 512 bytes of the disk show (od -Ax -tx1 /dev/)?
> Maybe there is still "0xaa55" on the disk at 0x1fe and the kernel
> thinks it is a DOS partition?
> 

Note that that is true for *ANY* partition scheme which is bootable,
since this is a requirement of the boot firmware interface, rather of
any particular partitioning scheme...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
