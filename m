Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261798AbSI2Ube>; Sun, 29 Sep 2002 16:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261789AbSI2Ubd>; Sun, 29 Sep 2002 16:31:33 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:7415 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261801AbSI2Uba>; Sun, 29 Sep 2002 16:31:30 -0400
Subject: Re: [PATCH] fix drm ioctl ABI default
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Christoph Hellwig <hch@sgi.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.44.0209292224590.12605-100000@mimas.fachschaften.tu-muenchen.de>
References: <Pine.NEB.4.44.0209292224590.12605-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Sep 2002 21:43:10 +0100
Message-Id: <1033332190.13762.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-29 at 21:33, Adrian Bunk wrote:
> > o Has security holes that are fixed in 4.2.1 only
> 
> The Debian maintainer of XFree86 claims that at least the Xlib problem
> doesn't affect 4.1 [1].

Thats the trivial one. The Shm stuff fixed going 4.2 to 4.2.1 is the bad
stuff, but I sure Brandon will have ported that over too

We'll all need 4.3 for newer boxes though - stuff like PCI domains and
the newer intel chipsets (eg 845G onboard video) simply dont backport 8(

