Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbTADXJj>; Sat, 4 Jan 2003 18:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbTADXJj>; Sat, 4 Jan 2003 18:09:39 -0500
Received: from r2l120.mistral.cz ([62.245.75.120]:1920 "EHLO ppc.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S261732AbTADXJh>;
	Sat, 4 Jan 2003 18:09:37 -0500
Date: Sun, 5 Jan 2003 00:17:29 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][FBDEV]: fb_putcs() and fb_setfont() methods
Message-ID: <20030104231729.GA1188@ppc.vc.cvut.cz>
References: <20030104204131.GD1319@ppc.vc.cvut.cz> <Pine.LNX.4.44.0301042109340.24903-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301042109340.24903-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2003 at 09:12:24PM +0000, James Simmons wrote:
> 
> > I'll be happier with character coordinates for text mode. 
> 
> Yuck!! Using fbcon for text modes is just bloat. For hardware text mode it 
> is much better to write a nice small console driver like newport_con.c

When I said before christmas that I'll have to write matroxcon to get
reasonable functionality, you laughed... Now, it is clear that there is
no other way...
 
> > could decide on case-by-case basis whether it will use its own code or 
> > generic without touching pointer (without modifying potentially constant
> > fb_ops structure common to all fbdev instances).
> 
> The patch was rejected. I working on your driver. I can throw in a text 
> mode driver as well. 

You can throw anything in and out, of course... It is GPL, after all.
Only question left is whether I'll be satisfied with functionality you
offer.
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz
 
