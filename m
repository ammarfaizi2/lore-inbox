Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273831AbRIREl0>; Tue, 18 Sep 2001 00:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273832AbRIRElQ>; Tue, 18 Sep 2001 00:41:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60427 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273831AbRIRElI>; Tue, 18 Sep 2001 00:41:08 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux 2.4.10-pre11
Date: 17 Sep 2001 21:41:25 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9o6j9l$461$1@cesium.transmeta.com>
In-Reply-To: <20010918031813.57E1062ABC@oscar.casa.dyndns.org> <E15jBLy-0008UF-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E15jBLy-0008UF-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
> 
> You need gcc 2.96 or higher to build the pre11 tree. I doubt that was
> intentional. Basically rip out all use of __builtin_expect
> 

Perhaps we should have a header which does #define __builtin_expect(X)
if your gcc version is 2.91-95?

   -hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
