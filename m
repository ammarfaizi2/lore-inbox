Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265513AbTAJSJq>; Fri, 10 Jan 2003 13:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265564AbTAJSJq>; Fri, 10 Jan 2003 13:09:46 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:45580 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265513AbTAJSJp>; Fri, 10 Jan 2003 13:09:45 -0500
Date: Fri, 10 Jan 2003 18:18:24 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [RFC][PATCH][FBDEV]: Setting fbcon's windows
 size
In-Reply-To: <1042000922.1049.101.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0301092140020.5660-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Here's an improved GTF implementation.  I was a bit delayed because I
> was trying to find a way to do square roots without using floating
> point.  The diff is against linux-2.5.54 + your latest fbdev.diff.

Applied. 

> but is more or less usable.  Tested with i810fb and rivafb. (For rivafb,
> I have to use a hacked version. The latest one does not work for the
> riva128).

What hack did you do? That is based on the latest riva driver from 2.4.2X.
 
> BTW, I downloaded the source code of read-edid, and it seems that the
> following monitor limits are parsable from the EDID block: HorizSync,
> VertRefresh, DotClock, and GTF capability. We may change info->monspecs
> to match that. Also, the EDID contains a list of supported modes, but
> there's only 4 of them(?).  

I figured monspec would have to be improved. I'm looking into the EDID 
info right now. I'm also looking at read-edid. Next I need to figure out 
how to use i2c to get this info.



