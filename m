Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbUCRJhU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 04:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbUCRJhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 04:37:20 -0500
Received: from gruby.cs.net.pl ([62.233.142.99]:48388 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S262465AbUCRJhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 04:37:19 -0500
Date: Thu, 18 Mar 2004 10:37:15 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH 2.6][RESEND] fbcon margins colour fix
Message-ID: <20040318093715.GB17838@gruby.cs.net.pl>
References: <20040317233135.GB3510@satan.blackhosts> <Pine.GSO.4.58.0403181020320.10688@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0403181020320.10688@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 10:21:31AM +0100, Geert Uytterhoeven wrote:
> On Thu, 18 Mar 2004, Jakub Bogusz wrote:
> > I sent it a few times to linux-kernel and at least one to
> > linux-fbdev-devel, but haven't seen any comments - and this annoying
> > changing margins colour seems to be still there in 2.6.4 (at least on
> > tdfxfb).
> 
> What happens on `reverse video' (i.e. black on white, like Sun) graphics cards?
> In that case the overscan color is white.

Uhm. What is palette entry for this white?
Or, more generally, how to find (palette colour number of) overscan
colour for current console?
Video erase character colour is not proper one as it may be different
even from background colour at the moment of vt switch.



-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
