Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbSLONhI>; Sun, 15 Dec 2002 08:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbSLONhI>; Sun, 15 Dec 2002 08:37:08 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:16783 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261305AbSLONhH>;
	Sun, 15 Dec 2002 08:37:07 -0500
Date: Sun, 15 Dec 2002 13:44:08 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Scott Robert Ladd <scott@coyotegulch.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel for Pentium 4 hyperthreading?
Message-ID: <20021215134408.GA20335@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Scott Robert Ladd <scott@coyotegulch.com>,
	linux-kernel@vger.kernel.org
References: <20021215005654.GE27658@fs.tum.de> <FKEAJLBKJCGBDJJIPJLJMEGPDLAA.scott@coyotegulch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FKEAJLBKJCGBDJJIPJLJMEGPDLAA.scott@coyotegulch.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2002 at 08:11:45PM -0500, Scott Robert Ladd wrote:

 > I've just received a new computer based on a 2.8 GHz Pentium 4 with
 > hyper-threading enabled. Yes, HT is enabled in the BIOS; yes, /proc/cpuinfo
 > shows the 'ht' flag; yes, I've compiled 2.4.20 (stock) with SMP and ACPI
 > enabled.
 > No, it doesn't work. cat /proc/cpuinfo reports a single CPU.

Note that just because /proc/cpuinfo shows 'ht' does not mean you can
use it in hyperthreaded mode. To do that, you also have to have >1
sibling in the physical package. Non-Xeon type P4's don't have the
extra sibling, so don't function as a hyperthreaded CPU.

 > Can 2.4.20 handle a Pentium 4 (not Xeon, mind you) with HT? What could I be
 > missing in my kernel build?

It's more a case of whats missing in your CPU package 8-)
 
		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
