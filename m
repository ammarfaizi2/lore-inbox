Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263837AbSLTSbL>; Fri, 20 Dec 2002 13:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbSLTSbK>; Fri, 20 Dec 2002 13:31:10 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:10757 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263837AbSLTSbK>; Fri, 20 Dec 2002 13:31:10 -0500
Date: Fri, 20 Dec 2002 18:39:10 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org, <benh@kernel.crashing.org>
Subject: Re: [PATCH] update chipsfb.c to new API
In-Reply-To: <15872.64993.241381.820669@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44.0212201835340.6471-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Here is a patch which updates chipsfb.c to the new 2.5 framebuffer
> API.  It simplifies the driver quite a bit, partly because the new API
> is simpler and partly because the driver really can only handle one
> 65550 chip, since we access the chip via inb/outb to fixed I/O port
> numbers.

Great!! Applied. 
 
> more because the VC_GETMODE etc. ioctls have been removed.  The 3400
> is an old and slow machine with a small hard disk and an old Linux/PPC
> installation on it, and I don't really want to compile up XFree86 on
> it.

Sounds like you need a cross-compiler setup.

P.S

  BTW there is also another ctfb driver which works on ix86 as well as 
ppc. It is at http://www.visuelle-maschinen.de/ctfb. I'm going to look at 
that as well. 


