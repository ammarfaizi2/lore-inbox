Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267492AbTAGViw>; Tue, 7 Jan 2003 16:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267485AbTAGViw>; Tue, 7 Jan 2003 16:38:52 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:19460 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267492AbTAGViv>; Tue, 7 Jan 2003 16:38:51 -0500
Date: Tue, 7 Jan 2003 21:46:23 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Antonino Daplas <adaplas@pol.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH][FBDEV]: fb_putcs() and fb_setfont()
 methods
In-Reply-To: <20030104231729.GA1188@ppc.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0301072143230.17129-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > I'll be happier with character coordinates for text mode. 
> > 
> > Yuck!! Using fbcon for text modes is just bloat. For hardware text mode it 
> > is much better to write a nice small console driver like newport_con.c
> 
> When I said before christmas that I'll have to write matroxcon to get
> reasonable functionality, you laughed... Now, it is clear that there is
> no other way...

No I didn't laugh. I didn't like the idea of another fbcon like system 
being developed just to support this text mode. I have no problem with 
a matroxcon. 

> You can throw anything in and out, of course... It is GPL, after all.
> Only question left is whether I'll be satisfied with functionality you
> offer.

:-) I'm working on your driver the latest few days. I managed to shrink 
most of the accel code into one common base.I still have alot to go tho.
You have a matroxfb_check_var which makes my life much easier. 


