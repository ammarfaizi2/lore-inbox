Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263715AbTKKTnV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 14:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263717AbTKKTnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 14:43:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10760 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263715AbTKKTnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 14:43:20 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.bkbits.net off the air
Date: 11 Nov 2003 11:43:04 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bore48$ubl$1@cesium.transmeta.com>
References: <fa.eto0cvm.1v20528@ifi.uio.no> <fa.onl48uv.1tmeb21@ifi.uio.no> <3FB0EEB5.5010804@myrealbox.com> <200311111438.47868.andrew@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200311111438.47868.andrew@walrond.org>
By author:    Andrew Walrond <andrew@walrond.org>
In newsgroup: linux.dev.kernel
> 
> My preferred solution is a single sequence file as described by Adreas:
> 
> Assuming sequence starts at 0,
> 
> To modify the repository, +1 to sequence file contents, modify repo, +1 to 
> sequence
> 
> To get a coherent copy,
> do
> 	seq1 = read(sequence file)
> 	rsync repo
> 	seq2 = read(sequence file)
> until seq1==seq2 and !(seq1&1)
> 

OK... this still doesn't deal with how to get mirrors to pick stuff up
with a minimum of fuss.  The "minimum of fuss" bit is *extremely*
important... I still haven't managed to get all mirrors to use rsync.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
