Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbSLUSjK>; Sat, 21 Dec 2002 13:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSLUSjK>; Sat, 21 Dec 2002 13:39:10 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:31911 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262813AbSLUSjK>;
	Sat, 21 Dec 2002 13:39:10 -0500
Date: Sat, 21 Dec 2002 18:46:32 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Build error (2.5.52): undefined reference to `agp_generic_agp_3_0_enable'
Message-ID: <20021221184632.GA28910@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	linux-kernel@vger.kernel.org
References: <20021221183904.GA18166@neon.pearbough.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021221183904.GA18166@neon.pearbough.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 21, 2002 at 07:39:04PM +0100, axel@pearbough.net wrote:
 > Hi,
 > 
 > Compilation of 2.5.52bk6 fails due to the following error :
 > drivers/built-in.o(.init.text+0x4e4f): undefined reference to
 > `agp_generic_agp_3_0_enable'

If Linus pulls soon, it should be fixed in -bk7
In the meantime, just enable CONFIG_AGP3

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
