Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbSLLN0B>; Thu, 12 Dec 2002 08:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbSLLN0B>; Thu, 12 Dec 2002 08:26:01 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:23172 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264624AbSLLN0A>;
	Thu, 12 Dec 2002 08:26:00 -0500
Date: Thu, 12 Dec 2002 13:33:39 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Joseph <jospehchan@yahoo.com.tw>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
Message-ID: <20021212133339.GE1145@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Joseph <jospehchan@yahoo.com.tw>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0212111151410.1397-100000@twin.uoregon.edu> <002e01c2a1bf$4bfde0b0$3716a8c0@taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002e01c2a1bf$4bfde0b0$3716a8c0@taipei.via.com.tw>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 05:17:29PM +0800, Joseph wrote:
 > Thanks for all response. :)
 > I think I know more why it downgrades.
 > But one more curious question.
 > In the file, arch/i386/Makefile, under kernel 2.5.51.
 > I found the C3 alignments , $(call check_gcc, -march=c3,-march=i486).
 > Does the C3 CPU type be included in gcc compile option??
 > I've downloaded the latest gcc 3.2.1 version.
 > But I don't find the c3 options in the file gcc/config/i396/i386.c, i386.h
 > or etc.

Not in a currently released gcc. CVS HEAD supports it, as will 3.3

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
