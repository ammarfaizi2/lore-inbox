Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289230AbSA1QpV>; Mon, 28 Jan 2002 11:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289231AbSA1QpL>; Mon, 28 Jan 2002 11:45:11 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:48794 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S289230AbSA1QpG>; Mon, 28 Jan 2002 11:45:06 -0500
Date: Mon, 28 Jan 2002 09:44:45 -0700
Message-Id: <200201281644.g0SGij202269@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KERN_INFO for devfs
In-Reply-To: <200201280750.g0S7oGE21742@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200201280750.g0S7oGE21742@Port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko writes:
> Primary purpose of this patch is to make KERN_WARNING and
> KERN_INFO log levels closer to their original meaning.
> Today they are quite far from what was intended.
> Just look what kernel writes at the WARNING level
> each time you boot your box!
> 
> Diff for devfs.
> --
> vda
> 
> diff --recursive -u linux-2.4.13-orig/fs/devfs/base.c linux-2.4.13-new/fs/devfs/base.c

This patch won't even remotely apply to 2.4.18-pre7. Please don't
submit patches which were generated against old kernels unless you've
verified that they apply to the latest kernel.

Furthermore, if you look at 2.4.18-pre7, you'll notice that devfs has
changed the way most of it's messages are generated, and uses the
KERN_ values quite a bit.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
