Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268306AbTBMV1f>; Thu, 13 Feb 2003 16:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268307AbTBMV1f>; Thu, 13 Feb 2003 16:27:35 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:61598 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S268306AbTBMV1d>;
	Thu, 13 Feb 2003 16:27:33 -0500
Date: Thu, 13 Feb 2003 21:33:15 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.60-bk pdflush oops.
Message-ID: <20030213213315.GC24878@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Valdis.Kletnieks@vt.edu,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030213205608.GB24109@codemonkey.org.uk> <200302132114.h1DLEmFT010583@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302132114.h1DLEmFT010583@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 04:14:48PM -0500, Valdis.Kletnieks@vt.edu wrote:
 > > Feb 13 20:30:24 mesh kernel: Call Trace:
 > > Feb 13 20:30:24 mesh kernel:  [<c014a8b4>] kmem_cache_alloc+0x134/0x140
 > > Feb 13 20:30:24 mesh kernel:  [<c014916f>] kmem_cache_create+0xbf/0x5a0
 > > Feb 13 20:30:24 mesh kernel:  [<c0105000>] _stext+0x0/0x30
 > > Feb 13 20:30:24 mesh kernel: 
 > > Feb 13 20:30:24 mesh kernel: Dentry cache hash table entries: 16384 (order: 5
 > , 131072 bytes)
 > So it's after test_wp_bit() is called, and before security_scaffolding_startup().
 > 
 > Interesting that you didn't get the 'sleeping function called' message?

Could be that one went out to serial console, but not to the logs
for some unknown reason. Unfortunatly my serial terminal has no
docs, and the 'scroll backwards' keys are somewhat not so obvious.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
