Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286468AbSABBRB>; Tue, 1 Jan 2002 20:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286491AbSABBQv>; Tue, 1 Jan 2002 20:16:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29446 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286468AbSABBQj>; Tue, 1 Jan 2002 20:16:39 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
Date: 1 Jan 2002 17:16:18 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a0tn12$ec8$1@cesium.transmeta.com>
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBMEAHEFAA.znmeb@aracnet.com> <E16LTvs-00016I-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E16LTvs-00016I-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
> 
> > 2. Isn't the boundary at 2^30 really irrelevant and the three "correct"
> > zones are (0 - 2^24-1), (2^24 - 2^32-1) and (2^32 - 2^36-1)?
> 
> Nope. The limit for directly mapped memory is 2^30.
> 

2^30-2^27 to be exact (assuming a 3:1 split and 128MB vmalloc zone.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
