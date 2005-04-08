Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262918AbVDHS43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbVDHS43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbVDHS43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:56:29 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:53447 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262918AbVDHS42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:56:28 -0400
Date: Fri, 8 Apr 2005 11:56:09 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Andrea Arcangeli <andrea@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050408185608.GA5638@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org> <4256C0F8.6030008@pobox.com> <Pine.LNX.4.58.0504081114220.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504081114220.28951@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 11:47:10AM -0700, Linus Torvalds wrote:

> Don't use NFS for development. It sucks for BK too.

Some times NFS is unavoidable.

In the best case (see previous email wrt to only stat'ing the parent
directories when you can) for a current kernel though you can get away
with 894 stats --- over NFS that would probably be tolerable.

After claiming such an optimization is probably not worth while I'm
now thinking for network filesystems it might be.
