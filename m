Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbSK0CWJ>; Tue, 26 Nov 2002 21:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264723AbSK0CWJ>; Tue, 26 Nov 2002 21:22:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54290 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264716AbSK0CWI>; Tue, 26 Nov 2002 21:22:08 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: uml-patch-2.5.49-1
Date: 26 Nov 2002 18:29:15 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <as1alr$1bs$1@cesium.transmeta.com>
References: <20021126141409.GA4589@ncsu.edu> <200211261833.NAA02294@ccure.karaya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200211261833.NAA02294@ccure.karaya.com>
By author:    Jeff Dike <jdike@karaya.com>
In newsgroup: linux.dev.kernel
>
> jlnance@unity.ncsu.edu said:
> > I think /proc/mm would be better implemented as /dev/mm.
> 
> What major and minor numbers should I assign to it?  And what would be
> the point of giving it a major and minor, anyway?
> 

Access control, ability to work in a chroot, ...

For major/minor, this is presumably a misc device (major 10) or, if
you don't need module support, a kernel core device (major 1), and
write to device@lanana.org to have a minor number assigned.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
