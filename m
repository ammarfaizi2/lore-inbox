Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbSLUOQH>; Sat, 21 Dec 2002 09:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbSLUOQH>; Sat, 21 Dec 2002 09:16:07 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:52390 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261321AbSLUOQG>;
	Sat, 21 Dec 2002 09:16:06 -0500
Date: Sat, 21 Dec 2002 14:23:22 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Next round of AGPGART fixes.
Message-ID: <20021221142322.GB24941@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021220124137.GA28068@suse.de> <Pine.LNX.4.44.0212202306330.14437-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212202306330.14437-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 11:07:58PM -0800, Linus Torvalds wrote:

 > > - AGP 3.0 now compiles as a module too.
 > > - beginnings of VIA KT400 AGP 3.0 support.
 > >   (Not functional yet, more work needed).
 > And with AGP 3 disabled, things do not even compile
 > 
 > 	In function `via_kt400_enable':
 > 	undefined reference to `agp_generic_agp_3_0_enable'
 > Hmm.

Blehh, I'll fix it up later, along with the strange
'unsafe modules' bug reported.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
