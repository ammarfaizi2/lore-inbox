Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269646AbRIHUCj>; Sat, 8 Sep 2001 16:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269786AbRIHUCb>; Sat, 8 Sep 2001 16:02:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48393 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269646AbRIHUCN>; Sat, 8 Sep 2001 16:02:13 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Re2: LOADLIN and 2.4 kernels
Date: 8 Sep 2001 13:02:05 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9ndtft$6ci$1@cesium.transmeta.com>
In-Reply-To: <51.10cc64a8.28cb50f8@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <51.10cc64a8.28cb50f8@aol.com>
By author:    Floydsmith@aol.com
In newsgroup: linux.dev.kernel
> 
> Yes, indeed, not loading himem does solve the problem I had. But, do to the 
> fact that I need extented memory (for a DOS ramdisk) and for some TSR(s) 
> (like smartdrv) for a LS-120 boot disk I use as both a Linux and DOS "rescue" 
> disk, I need "himem".
> 

Someone reported to me that LOADLIN consistently fails to load kernels
> 1 MB both with and without A20 changes; probably it tries to use the
old "sector count" field in the kernel.  This would explain what we
have observed, and so I consider this matter closed as far as I'm
concerned.  LOADLIN needs to be updated to continue to be useful, and
I don't know if Hans is still around, even.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
