Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261793AbTCLQOH>; Wed, 12 Mar 2003 11:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261798AbTCLQOH>; Wed, 12 Mar 2003 11:14:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18948 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261793AbTCLQOF>; Wed, 12 Mar 2003 11:14:05 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Kernel setup()
Date: 12 Mar 2003 08:24:36 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b4nn04$3gk$1@cesium.transmeta.com>
References: <Pine.GHP.4.53.0303120915340.16277@alderaan.science-computing.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.GHP.4.53.0303120915340.16277@alderaan.science-computing.de>
By author:    Oliver Tennert <tennert@science-computing.de>
In newsgroup: linux.dev.kernel
> 
> My question is: is pivot_root deprecated by now? I just am quite dazzled
> and want to know how to __cleanly__ handle the mounting of a new root
> device.
> 

pivot_root() is the currently preferred method.  Depending on where
the initramfs is by the time Linux 2.6 comes out it may be replaced by
then, but for 2.4, pivot_root() is the way to go.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
