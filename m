Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265947AbSLDHZr>; Wed, 4 Dec 2002 02:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266257AbSLDHZr>; Wed, 4 Dec 2002 02:25:47 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:60582 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265947AbSLDHZp>; Wed, 4 Dec 2002 02:25:45 -0500
Date: Wed, 4 Dec 2002 08:32:18 +0100
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
Message-ID: <20021204073218.GA1025@iliana>
References: <Pine.LNX.4.44.0212022027510.18805-100000@phoenix.infradead.org> <1038917280.1228.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1038917280.1228.7.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 05:22:35PM +0500, Antonino Daplas wrote:
> >   2) The ability to go back to vga text mode on close of /dev/fb. 
> >      Yes fbdev/fbcon supports that now. 
> 
> I'll take a stab at writing VGA save/restore routines which hopefully is
> generic enough to be used by various hardware.  No promises though, VGA
> programming gives me a headache :(

BTW, i am writing a fbdev for a card where the docs tell me to disable
vga output before enabling graphical output. Does i need to do this in
the fbdev i write, or is it already handled by the vga layer, or
whatever ?

Friendly,

Sven Luther
