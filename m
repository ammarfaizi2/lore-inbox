Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131125AbRCGRuh>; Wed, 7 Mar 2001 12:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131128AbRCGRu1>; Wed, 7 Mar 2001 12:50:27 -0500
Received: from gull.prod.itd.earthlink.net ([207.217.121.85]:31942 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S131125AbRCGRuJ>; Wed, 7 Mar 2001 12:50:09 -0500
Date: Wed, 7 Mar 2001 01:51:07 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Lucca <sdlucca@mindspring.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: nvidia fb 0.9.0
Message-ID: <Pine.LNX.4.31.0103070145010.1335-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Is this a known problem?  Are there work-arounds?

Yes. The problem is caused by the fbdev driver using 8 bit width for its
RAMDAC and the X server uses 6 bits. Try teh UseFBDev option for the X
server.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

