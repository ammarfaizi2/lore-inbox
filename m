Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263818AbSJHU63>; Tue, 8 Oct 2002 16:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSJHU63>; Tue, 8 Oct 2002 16:58:29 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:26069 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S263818AbSJHU6G>;
	Tue, 8 Oct 2002 16:58:06 -0400
Date: Tue, 8 Oct 2002 22:06:31 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: missing cache tag
Message-ID: <20021008210631.GA23678@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <E17yzTn-0004r2-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17yzTn-0004r2-00@the-village.bc.nu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 07:53:15PM +0100, Alan Cox wrote:
 > diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/arch/i386/kernel/cpu/intel.c linux.2.5.41-ac1/arch/i386/kernel/cpu/intel.c
 > --- linux.2.5.41/arch/i386/kernel/cpu/intel.c	2002-10-02 21:33:55.000000000 +0100
 > +++ linux.2.5.41-ac1/arch/i386/kernel/cpu/intel.c	2002-10-04 16:33:09.000000000 +0100
 > @@ -127,6 +127,7 @@
 >  	{ 0x7B, LVL_2,      512 },
 >  	{ 0x7C, LVL_2,      1024 },
 >  	{ 0x82, LVL_2,      256 },
 > +	{ 0x83, LVL_2,      512 },
 >  	{ 0x84, LVL_2,      1024 },
 >  	{ 0x85, LVL_2,      2048 },
 >  	{ 0x00, 0, 0}

More complete set of tags, and related fixes in already merged in -bk

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
