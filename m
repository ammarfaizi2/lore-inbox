Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275489AbTHNUuh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275514AbTHNUuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:50:37 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:30219 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S275489AbTHNUub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:50:31 -0400
Date: Thu, 14 Aug 2003 21:50:30 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Jakub Bogusz <qboosh@pld-linux.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tdfxfb in 2.6: fix for background used in fbcon_clear
In-Reply-To: <20030814201325.GB27236@satan.blackhosts>
Message-ID: <Pine.LNX.4.44.0308142150220.15200-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied. I will test it tonight.


On Thu, 14 Aug 2003, Jakub Bogusz wrote:

> It was already posted to linux-fbdev-devel, but I haven't got any
> comments...
> Attached patch is rather simple and obvious.
> 
> ----- Forwarded message from Jakub Bogusz <qboosh at pld.org.pl> -----
> 
> Date: Thu, 31 Jul 2003 01:43:27 +0200
> From: Jakub Bogusz <qboosh at pld.org.pl>
> To: linux-fbdev-devel at lists.sourceforge.net
> Subject: [PATCH] tdfxfb: fix for background used in fbcon_clear
> 
> Hello,
> 
> This time I checked recent linux-fbdev-devel archives - and didn't see
> any patch for this issue. So here is my fix.
> 
> There was wrong color used in fillrect in 16/24/32bpp (pseudo_palette
> mapping was omitted), which resulted in ugly black (well, almost black)
> rectangles painted when some "clear" terminal command was sent (like
> "^[[J", "^[[K") with background colour different than black.
> It was visible e.g. in mc's View.
> 
> [...]
> 
> 

