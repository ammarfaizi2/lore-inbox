Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266552AbSLUG6i>; Sat, 21 Dec 2002 01:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266555AbSLUG6i>; Sat, 21 Dec 2002 01:58:38 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27917 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266552AbSLUG6h>; Sat, 21 Dec 2002 01:58:37 -0500
Date: Fri, 20 Dec 2002 23:07:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Next round of AGPGART fixes.
In-Reply-To: <20021220124137.GA28068@suse.de>
Message-ID: <Pine.LNX.4.44.0212202306330.14437-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Dec 2002, Dave Jones wrote:
>
> - AGP 3.0 now compiles as a module too.
> - beginnings of VIA KT400 AGP 3.0 support.
>   (Not functional yet, more work needed).

And with AGP 3 disabled, things do not even compile

	In function `via_kt400_enable':
	undefined reference to `agp_generic_agp_3_0_enable'

Hmm.

		Linus

