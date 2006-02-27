Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751517AbWB0RU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbWB0RU7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 12:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWB0RU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 12:20:59 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:24012 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751517AbWB0RU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 12:20:58 -0500
To: jdike@addtoit.com
CC: fuse-devel@lists.sourceforge.net,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <20060227170826.GA5481@ccure.user-mode-linux.org> (message from
	Jeff Dike on Mon, 27 Feb 2006 12:08:26 -0500)
Subject: Re: [uml-devel] [Announce] mountlo 0.5 - Loopback mounting in userspace
References: <E1FDk1G-0004S6-00@dorka.pomaz.szeredi.hu> <20060227170826.GA5481@ccure.user-mode-linux.org>
Message-Id: <E1FDm2v-0004gV-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 27 Feb 2006 18:20:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm proud to announce a new version of my pet project 'mountlo', a
> > utility which works similarly to 'mount -o loop', but the filesystem
> > runs entirely in userspace.
> > 
> > While arguably it is quite useless, I like it because it combines some
> > of my favorite technologies (Linux, UML and FUSE) with very little
> > additional glue code.
> 
> Very cute.  I'm in the process of doing something similar, except I'm
> integrating a FUSE server into the UML kernel to export the UML
> filesystem to the host.  So far, I can cd and ls inside the mount -
> lookup and readdir are implemented.

Great.  I always wanted to do the exporting inside the kernel, but put
it off as being too hard :)

Miklos
