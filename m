Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285498AbSAPSOg>; Wed, 16 Jan 2002 13:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285730AbSAPSO3>; Wed, 16 Jan 2002 13:14:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15365 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285498AbSAPSOT>; Wed, 16 Jan 2002 13:14:19 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Query about initramfs and modules
Date: 16 Jan 2002 10:13:55 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a24ft3$4au$1@cesium.transmeta.com>
In-Reply-To: <15428.47094.435181.278715@irving.iisd.sra.com> <a22nc0$2fh$1@cesium.transmeta.com> <15429.48638.96256.842851@irving.iisd.sra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <15429.48638.96256.842851@irving.iisd.sra.com>
By author:    David Garfield <garfield@irving.iisd.sra.com>
In newsgroup: linux.dev.kernel
> 
> Agreed.  However, this work could easily be performed by an insmod
> variant that takes a module, a "System.map", and a kernel image, and
> produces a cpio file as output instead of passing the data to the
> kernel for immediate processing.  The kernel mechanism would then only
> need to unpack the pieces, relocate, and make the system calls.
> 

How do you know where the running kernel will be allocating address
space for the module?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
