Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262174AbREQCUV>; Wed, 16 May 2001 22:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262175AbREQCUK>; Wed, 16 May 2001 22:20:10 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:4874 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262174AbREQCUC>; Wed, 16 May 2001 22:20:02 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: vfat large file support
Date: 16 May 2001 19:19:38 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9dvcfq$o3g$1@cesium.transmeta.com>
In-Reply-To: <20010517040000.A22911@convergence.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010517040000.A22911@convergence.de>
By author:    Felix von Leitner <leitner@convergence.de>
In newsgroup: linux.dev.kernel
>
> I can't copy a file larger than 2 gigs to my vfat partition.
> What gives?  2.4.4-ac5 kernel.  My cp copies 2 gigs and then aborts.
> 
>   $ echo foo >> file_on_vfat_partition
> 
> causes the shell to become unresponsive and consume lots of CPU time.
> 

VFAT doesn't support files larger than 2 GB.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
