Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSLPUGW>; Mon, 16 Dec 2002 15:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSLPUGV>; Mon, 16 Dec 2002 15:06:21 -0500
Received: from d214.dial.univie.ac.at ([131.130.203.214]:2432 "EHLO server.lan")
	by vger.kernel.org with ESMTP id <S261426AbSLPUGV>;
	Mon, 16 Dec 2002 15:06:21 -0500
From: Melchior FRANZ <mfranz@users.sourceforge.net>
To: Alex Goddard <agoddard@purdue.edu>
Subject: Re: 2.5.52 and modules (lots of unresolved symbols)?
Date: Mon, 16 Dec 2002 20:22:50 +0100
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
References: <20021216094514.GA735@ulima.unil.ch> <200212161813.gBGIDuHv029134@server.lan> <Pine.LNX.4.50L0.0212161352240.1154-100000@dust.ebiz-gw.wintek.com>
In-Reply-To: <Pine.LNX.4.50L0.0212161352240.1154-100000@dust.ebiz-gw.wintek.com>
X-PGP: http://www.unet.univie.ac.at/~a8603365/melchior.franz
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200212162022.52394@pflug3.gphy.univie.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alex Goddard -- Monday 16 December 2002 14:54:
> On Mon, 16 Dec 2002, Melchior FRANZ wrote:
> > Why doesn't the Makefile simply define "DEPMOD = depmod"
> > instead of "DEPMOD = /sbin/depmod" (and likewise for
> > genksyms)? 
> 
> Ah.  That makes sense.  Your question is the same as mine, then.  Why 
> define an absolute path for depmod?

That's because people compiling the kernel as user don't have depmod
in their path. (I didn't think of that before.) Now I've installed
the module_init_tools to /sbin (while I had them in /usr/local/sbin
before, as the README suggests as variant 1a).

m.
