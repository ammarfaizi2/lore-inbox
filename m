Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbSLMLt4>; Fri, 13 Dec 2002 06:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262354AbSLMLt4>; Fri, 13 Dec 2002 06:49:56 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:62343 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262296AbSLMLtv>;
	Fri, 13 Dec 2002 06:49:51 -0500
Date: Fri, 13 Dec 2002 11:57:26 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Joseph <jospehchan@yahoo.com.tw>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
Message-ID: <20021213115726.GB31187@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Joseph <jospehchan@yahoo.com.tw>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0212111151410.1397-100000@twin.uoregon.edu> <002e01c2a1bf$4bfde0b0$3716a8c0@taipei.via.com.tw> <20021212133339.GE1145@suse.de> <004d01c2a274$915cf690$3716a8c0@taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004d01c2a274$915cf690$3716a8c0@taipei.via.com.tw>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2002 at 02:55:04PM +0800, Joseph wrote:

 > I've checked the gcc CVS. But it seems to use i486 pluse MMX and 3DNOW
 > instructions.
 > * config.gcc: Treat winchip_c6-*|winchip2-*|c3-* as pentium-mmx.
 > * config/i386/i386.c (processor_alias_table): Add winchip-c6, winchip2 and
 > c3.
 > * doc/invoke.texi: Mention new aliases.
 > **  {"c3", PROCESSOR_I486, PTA_MMX | PTA_3DNOW},   **
 > Is there any plan to optimize for C3 CPU in future gcc released version?

Maybe if an optimisation guide appears for the C3.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
