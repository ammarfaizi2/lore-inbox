Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314392AbSEBMsG>; Thu, 2 May 2002 08:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314393AbSEBMsF>; Thu, 2 May 2002 08:48:05 -0400
Received: from ns.suse.de ([213.95.15.193]:43530 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314392AbSEBMsF>;
	Thu, 2 May 2002 08:48:05 -0400
Date: Thu, 2 May 2002 14:48:04 +0200
From: Dave Jones <davej@suse.de>
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.12-dj1
Message-ID: <20020502144804.A16935@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rudmer van Dijk <rudmer@legolas.dynup.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020501203612.GA4167@suse.de> <20020502110625.3DFA41EF73@Cantor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 01:06:07PM +0200, Rudmer van Dijk wrote:
 > drivers/block/block.o: In function `ramdisk_updatepage':
 > drivers/block/block.o(.text+0x3740): undefined reference to 
 > `mark_buffer_uptodate'

The chunk of code introduced to the ramdisk code in 2.5.12-dj1 is
a forward port of what happened in 2.4.  It probably needs fixing up
again (I've rewritten and jiggled it a little since the initial
forward port).  I'm not entirely sure it works as advertised anymore.

It's on my radar, I'll take a look for the next patch I put out.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
