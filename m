Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbSLFM1b>; Fri, 6 Dec 2002 07:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262416AbSLFM1b>; Fri, 6 Dec 2002 07:27:31 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:32267 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S262414AbSLFM1a>; Fri, 6 Dec 2002 07:27:30 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH 1/3: FBDEV: VGA State Save/Restore
	module
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0212060051080.31967-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0212060051080.31967-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Dec 2002 20:27:16 +0500
Message-Id: <1039188475.1405.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 05:53, James Simmons wrote:
> > 
> > Only the structure definition of fb_vgastate is in fb.h.  For drivers
> > without a vga core, they'll just won't link to it and it won't be
> > compiled.  Plus, vga.h is not a common header (not located in
> > include/asm or include/linux) and it contains a lot of declarations and
> > definitions which are irrelevant to most drivers or are already
> > duplicated.  This will be messier, I think.  
> 
> I like to move vga.h to include/video. And yes I like to clean it up. The 
> reason is I like to implement the function in vga.h and some in vgastate 
> into vgacon.c. It would be nice if vgacon could support different hardware 
> states per VC instead of changing every virtual console for everything. 
> The other dream is I like to see vgacon become firmware independent. 
> 
OK.

Tony

