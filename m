Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbSLMOEl>; Fri, 13 Dec 2002 09:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbSLMOEl>; Fri, 13 Dec 2002 09:04:41 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:21128 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264625AbSLMOEl>;
	Fri, 13 Dec 2002 09:04:41 -0500
Date: Fri, 13 Dec 2002 14:11:27 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.51: new warning from lilo
Message-ID: <20021213141127.GA1633@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021212193451.GA458@elf.ucw.cz> <1039789418.25121.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039789418.25121.25.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2002 at 02:23:38PM +0000, Alan Cox wrote:
 > > Warning: Kernel & BIOS return differing head/sector geometries for
 > > device 0x80
 > >     Kernel: 8944 cylidners, 15 heads, 63 sectors
 > >       BIOS: 525 cylinders, 255 heads, 63 sectors
 > > 
 > > lilo did not warn under 2.5.50. Now... Will it boot?
 > 
 > Someone took various bits of geometry mapping out of the kernel. It will
 > now give different values. As to whether lilo will still boot I don't
 > know. I'd be suprised if it was a problem. 

Hasn't caused a problem on any of my test boxes.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
