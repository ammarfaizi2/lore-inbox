Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267159AbTAFVnV>; Mon, 6 Jan 2003 16:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267151AbTAFVnU>; Mon, 6 Jan 2003 16:43:20 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:29709 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267173AbTAFVnT>; Mon, 6 Jan 2003 16:43:19 -0500
Date: Mon, 6 Jan 2003 21:51:44 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [FBDEV]: accel_putcs() buffer overflow fix
In-Reply-To: <1041514436.1002.31.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0301062151140.31831-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 1. If size of bitmap exceeds size of pixmap buffer, subdivide and do
> multiple imageblits.
> 
> 2. Use generic fb_pan_display() instead of info->fbops->fb_pan_display()
> in update_var()

Applied.

