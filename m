Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbSKTPuD>; Wed, 20 Nov 2002 10:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261416AbSKTPuD>; Wed, 20 Nov 2002 10:50:03 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:63878 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261376AbSKTPt7>;
	Wed, 20 Nov 2002 10:49:59 -0500
Date: Wed, 20 Nov 2002 15:55:24 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Micha? Piotrowski <mkkpiotrowski@wp.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.4.20-rc2
Message-ID: <20021120155524.GB5678@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Micha? Piotrowski <mkkpiotrowski@wp.pl>,
	linux-kernel@vger.kernel.org
References: <3DDBA621.6030208@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDBA621.6030208@wp.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 04:11:29PM +0100, Micha? Piotrowski wrote:
 > 
 > Unable to handle kernel NULL pointer dereference at virtual addres 00000188
 > *pde = 00000000
 > Oops: 0002
 > CPU: 0
 > EIP: 0010:[<c20913a1>]  Not tained
 > EFLAGS: 00010246
 > eax: 00000000   ebx: 00000000   ecx: c10e1100   edx: c083c440
 > esi: c10d7ca0   edi: c083c440   ebp: c04f8000   esp: c0203efc
 > ds: 0018   es: 0018   ss: 0018
 > Process swapper (pid: 0, stackpage=c0203000)
 > Stack:	c083c440 c025c4c4 c083c440 c025c344 c0183038 c025c4c4 c083c440 
 > c10d7ca0
 > 	00000000 c04f8000 c025c4c4 c10d7ca0 c2091579 00000001 c10f2160 
 > 	00000000
 > 	c10f2160 c025c4c4 00000202 c025c344 c01834e6 c025c4c4 c2091510 
 > 	c1059820
 > Call Trace: [<c0183038>] [<c2091579>] [<c01834e6>] [<c2091510>] [<c010822d>]
 > 	[<c01083a8>] [<c0105310>] [<c010a818>] [<c0105310>] [<c0105334>]
 > 	[<c01053a2>] [<c0105000>]
 > Code: c7 80 88 01 00 00 02 00 00 00 74 81 8b 45 2c 8b 40 24 50 8b
 > <0> Kernel panic: Aiee killing interupt handler!
 > Interupt handler - not syncing

Please read Documentation/oops-tracing.txt
This needs to be fed through ksymoops

		Dave
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
