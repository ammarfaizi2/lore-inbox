Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262344AbSJ2VjT>; Tue, 29 Oct 2002 16:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262366AbSJ2VjT>; Tue, 29 Oct 2002 16:39:19 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:39372 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262344AbSJ2VjS>; Tue, 29 Oct 2002 16:39:18 -0500
Date: Tue, 29 Oct 2002 14:38:51 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Antonino Daplas <adaplas@pol.net>
Subject: Re: [BK updates] fbdev changes updates.
In-Reply-To: <20021029200838.GA27552@suse.de>
Message-ID: <Pine.LNX.4.33.0210291437050.1363-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, Oct 29, 2002 at 12:45:10PM -0800, James Simmons wrote:
>  > The reason for this is we will see in the future embedded ix86
>  > boards with things like i810 framebuffers with NO vga core. In this case
>  > we will need a fbdev driver for a graphical console. Thus the agp code
>  > must be started before the fbdev layer.
>
> Can you explain exactly what the agpgart code is doing that needs
> to be done earlier than framebuffer ? I don't see any reason for this
> change. There should be no GART mappings until we've booted userspace
> (except for the case of IOMMU)

Best to ask the author of the i810 framebuffer driver. He can tell you his
need for AGP stuff. I CC.


