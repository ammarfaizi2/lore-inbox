Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289815AbSAPCJ3>; Tue, 15 Jan 2002 21:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289813AbSAPCJS>; Tue, 15 Jan 2002 21:09:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63753 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289809AbSAPCJK>; Tue, 15 Jan 2002 21:09:10 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Query about initramfs and modules
Date: 15 Jan 2002 18:09:04 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a22nc0$2fh$1@cesium.transmeta.com>
In-Reply-To: <15428.47094.435181.278715@irving.iisd.sra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <15428.47094.435181.278715@irving.iisd.sra.com>
By author:    David Garfield <garfield@irving.iisd.sra.com>
In newsgroup: linux.dev.kernel
>
> Hearing all this talk about initramfs and eliminating hardwired
> drivers, it occurs to me to ask:
> 
> Can/will the initramfs mechanism be made to implicitly load into the
> kernel the modules (or some of the modules) in the image?
> 

No.  The bulk of the work of module loading is the job for insmod.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
