Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbSLHRd0>; Sun, 8 Dec 2002 12:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSLHRd0>; Sun, 8 Dec 2002 12:33:26 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:42885 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261427AbSLHRdZ>;
	Sun, 8 Dec 2002 12:33:25 -0500
Date: Sun, 8 Dec 2002 17:38:16 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Z F <mail4me9999@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPU cache problem
Message-ID: <20021208173816.GB12941@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Z F <mail4me9999@yahoo.com>, linux-kernel@vger.kernel.org
References: <20021207043158.45345.qmail@web20420.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021207043158.45345.qmail@web20420.mail.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 08:31:58PM -0800, Z F wrote:
 > Hello everybody
 > 
 > Sorry to bother you with such a question, but I have a 
 > Intel 1.7GHz Celeron processor with ASUS P4S533 motherboard.
 > The problem I have is that cat /proc/cpuinfo reports that
 > 
 > cache size      : 20 KB
 > 
 > As far as I know, the CPU has 128K L2 cache.
 > 
 > The kernel version installed on my computer is 2.4.18.

This bug is fixed in Marcelo's current tree, fix will be in 2.4.20pre1
 
 > I tried using cachesize=128 as a boot parameter, but it did not help.

Also a fix for a different bug where this gets used too late.

		Dave
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
