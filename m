Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263006AbTCTXyK>; Thu, 20 Mar 2003 18:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262970AbTCTXyK>; Thu, 20 Mar 2003 18:54:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51729 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263006AbTCTXyJ>; Thu, 20 Mar 2003 18:54:09 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: major/minor split
Date: 20 Mar 2003 16:04:58 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b5dkva$mgc$1@cesium.transmeta.com>
References: <UTC200303202224.h2KMOXC01107.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0303210016360.5042-100000@serv>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0303210016360.5042-100000@serv>
By author:    Roman Zippel <zippel@linux-m68k.org>
In newsgroup: linux.dev.kernel
> 
> I mean via mknod, e.g. if the user has a major/minor number, how should it 
> be converted to a dev_t number?
> 

Using MKDEV().  Basically, use the old format if it fits (for
compatibility), otherwise the new format.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
