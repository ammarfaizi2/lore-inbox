Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266854AbUHCVTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266854AbUHCVTO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266864AbUHCVTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:19:13 -0400
Received: from aun.it.uu.se ([130.238.12.36]:37873 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266854AbUHCVTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:19:12 -0400
Date: Tue, 3 Aug 2004 23:11:39 +0200 (MEST)
Message-Id: <200408032111.i73LBdV8000405@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: bunk@fs.tum.de
Subject: Re: updated gcc-3.4 patches for 2.4.27-rc4
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2004 21:34:54 +0200, Adrian Bunk wrote:
> On Tue, Aug 03, 2004 at 09:02:22PM +0200, Mikael Pettersson wrote:
> > [Resend. 1st post seems to have gone into a /dev/null somewhere.]
> > 
> > The gcc-3.4 patches for the 2.4.27-rc4 kernel have been updated:
> >...
> > http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc34-misc-fixes-2.4.27-rc4
> >...
> 
> This still contains the compiler.h patch which shouldn't be there.

It's currently needed since the inlining failures caused by
__attribute__((always_inline)) haven't been fixed yet in 2.4.
This patch kit is used for production, you know :-) Things
must work.

I'll remove the compiler.h patch later when I have time to deal
with the inlining failures.

/Mikael
