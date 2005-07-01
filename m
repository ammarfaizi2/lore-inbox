Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263304AbVGAJss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbVGAJss (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 05:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbVGAJss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 05:48:48 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:59662 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263306AbVGAJsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 05:48:45 -0400
To: frederik.deweerdt@gmail.com
CC: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
In-reply-to: <20050701074641.GD8679@gilgamesh.home.res> (message from Frederik
	Deweerdt on Fri, 1 Jul 2005 09:46:41 +0200)
Subject: Re: FUSE merging?
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu> <20050630022752.079155ef.akpm@osdl.org> <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu> <1120125606.3181.32.camel@laptopd505.fenrus.org> <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu> <1120126804.3181.34.camel@laptopd505.fenrus.org> <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu> <20050701074641.GD8679@gilgamesh.home.res>
Message-Id: <E1DoI7o-0002ZB-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 01 Jul 2005 11:47:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could this be solved by implementing some sort of (optional) timeout on fuse
> syscalls (in request_send)?

Yes, but that would be thousand times worse than the current solution.
You just can't know in advance, what a "sane" timeout value is.

Miklos
