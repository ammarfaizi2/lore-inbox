Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278472AbRJOWxy>; Mon, 15 Oct 2001 18:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278473AbRJOWxo>; Mon, 15 Oct 2001 18:53:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26380 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278472AbRJOWxd>; Mon, 15 Oct 2001 18:53:33 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: libz, libbz2, ramfs and cramfs
Date: 15 Oct 2001 15:53:53 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9qfpe1$esn$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110151436040.755-100000@lisa.rhpk.springfield.inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0110151436040.755-100000@lisa.rhpk.springfield.inwind.it>
By author:    Cristiano Paris <c.paris@libero.it>
In newsgroup: linux.dev.kernel
> 
> Third, is there any project which tries to implement bzip2 algorithm
> inside the kernel ? Does it give better compression ratios on 1-page-long
> data ?
> 

No, in fact, it has been measured to be somewhere between the same and
significantly worse, even with the 32K chunk size that zisofs uses.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
