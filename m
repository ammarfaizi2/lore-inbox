Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbSKTVdg>; Wed, 20 Nov 2002 16:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbSKTVdg>; Wed, 20 Nov 2002 16:33:36 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:52361 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262730AbSKTVdf>;
	Wed, 20 Nov 2002 16:33:35 -0500
Date: Wed, 20 Nov 2002 21:38:56 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Margit Schubert-While <margit@margit.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc2 strange L1 cache values
Message-ID: <20021120213856.GA16160@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Margit Schubert-While <margit@margit.com>,
	linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021120213759.00b178b0@mail.dns-host.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20021120213759.00b178b0@mail.dns-host.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 09:40:51PM +0100, Margit Schubert-While wrote:
 > Another peculiar thing - Why is /proc/cpuinfo showing "ht" ?
 > 
 > processor           : 0
 > vendor_id           : GenuineIntel
 > cpu family           : 15
 > model                 : 2
 > model name       : Intel(R) Pentium(R) 4 CPU 2.40GHz
 > flags                   : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr 
 > pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm

All Pentium 4's seem to show it, though not all have them have
the extra sibling.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
