Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313924AbSD1R6a>; Sun, 28 Apr 2002 13:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313927AbSD1R63>; Sun, 28 Apr 2002 13:58:29 -0400
Received: from cs145025.pp.htv.fi ([213.243.145.25]:41742 "EHLO chip.2y.net")
	by vger.kernel.org with ESMTP id <S313924AbSD1R63>;
	Sun, 28 Apr 2002 13:58:29 -0400
Date: Sun, 28 Apr 2002 20:57:59 +0300 (EEST)
From: Panu Matilainen <pmatilai@welho.com>
X-X-Sender: pmatilai@chip.2y.net
To: Pete Zaitcev <zaitcev@redhat.com>
cc: nfs@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: 1279 mounts
In-Reply-To: <20020427213236.A20253@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0204282055470.2935-100000@chip.2y.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Apr 2002, Pete Zaitcev wrote:

> > Date: Fri, 26 Apr 2002 11:25:33 +0300 (EEST)
> > From: Panu Matilainen <pmatilai@welho.com>
> 
> > I've got quite a few users here who "need" this functionality and it's 
> > included in our RH-based custom kernels. Having it as a separate patch 
> > for 2.4 is no problem, for 2.5 I'm hoping we finally move to 32bit device 
> > numbers...
> 
> Mind, we only ship the unnamed majors part, but not the NFS part.
> There is no word from util-linux maintainer about required
> changes to mount(8), so I was cautious about doint that.

Sure, I know. In these cases getting the limit from 255 to around 800 is 
enough so the mount patch isn't even needed.

	- Panu -

