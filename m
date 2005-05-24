Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVEXO0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVEXO0Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 10:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVEXO0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 10:26:16 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:22795 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261371AbVEXO0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 10:26:12 -0400
To: rminnich@lanl.gov
CC: penberg@gmail.com, ericvh@gmail.com, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       penberg@cs.helsinki.fi
In-reply-to: <Pine.LNX.4.58.0505240803410.9237@enigma.lanl.gov>
	(rminnich@lanl.gov)
Subject: Re: [V9fs-developer] Re: [RFC][patch 3/7] v9fs: VFS inode operations
 (2.0-rc6)
References: <200505232225.j4NMPmH9014347@ms-smtp-01-eri0.texas.rr.com>
 <84144f0205052401432ffa1075@mail.gmail.com> <Pine.LNX.4.58.0505240803410.9237@enigma.lanl.gov>
Message-Id: <E1DaaLl-0004Ap-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 May 2005 16:25:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The reason I prefer the 'retval = blah blah; return retval;' usage is that
> I frequently have run v9fs in UML, and debugging is just easier. Set the
> breakpoint in v9fs_vfs_create, step through, maybe skip over that
> v9fs_create function, look at retval.

Why don't you just use 'finish'.  That prints the return value.

Every unnecessary line in a function makes it harder to read.  That
includes over-commenting and overuse of empty lines.

Miklos
