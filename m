Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266640AbTAJXvb>; Fri, 10 Jan 2003 18:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266649AbTAJXvb>; Fri, 10 Jan 2003 18:51:31 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:51727 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266640AbTAJXva>; Fri, 10 Jan 2003 18:51:30 -0500
Date: Sat, 11 Jan 2003 00:00:13 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [RFC][PATCH][FBDEV]: Setting fbcon's windows
 size
In-Reply-To: <1042213013.932.13.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0301102359340.6594-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hopefully it's the final installment for the GTF implementation.
> 
> The fb_get_mode() function checks for a bit in 'flags' (FB_IGNOREMON) so
> it will generate GTF timings regardless of the validity of
> info->monspecs.  This way, drivers can still use GTF even if they don't
> have the operational limits of the monitor.  They'll just decide what is
> a practical safe limit.

Applied. 

