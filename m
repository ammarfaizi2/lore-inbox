Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267377AbSLERbk>; Thu, 5 Dec 2002 12:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267378AbSLERbk>; Thu, 5 Dec 2002 12:31:40 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:60690 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267377AbSLERbj>; Thu, 5 Dec 2002 12:31:39 -0500
Date: Thu, 5 Dec 2002 17:39:11 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Antonino Daplas <adaplas@pol.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH 1/3: FBDEV: VGA State Save/Restore module
In-Reply-To: <96665BC46B2@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0212051738280.31967-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Look at vgacon. Uses font block 0,2,3 from plane 2 when built
> without BROKEN_GRAPHICS_PROGRAMS, or 0,1 when built with 
> BROKEN_GRAPHICS_PROGRAMS. So if you want just restore vgacon environment,
> save only these 4 blocks (4*8K = 32K). Or you want to save whole
> VGA memory, and then save whole 256KB, without tricks while saving
> planes 0 & 1.

If you could get ride of the dependance on BROKEN_GRAPHICS_PROGRAM I would 
be really happy.


