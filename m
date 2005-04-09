Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVDIPmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVDIPmf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 11:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVDIPme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 11:42:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:42666 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261253AbVDIPmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 11:42:33 -0400
Date: Sat, 9 Apr 2005 08:40:03 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jgarzik@pobox.com, matthias.christian@tiscali.de, andrea@suse.de,
       cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
Message-Id: <20050409084003.02c83b9f.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0504081114220.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<20050408041341.GA8720@taniwha.stupidest.org>
	<Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
	<20050408071428.GB3957@opteron.random>
	<Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org>
	<4256AE0D.201@tiscali.de>
	<Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
	<4256C0F8.6030008@pobox.com>
	<Pine.LNX.4.58.0504081114220.28951@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> then git will open have exactly _one_ 
> file (no searching, no messing around), which contains absolutely nothing 
> except for the compressed (and SHA1-signed) old contents of the file. It 
> obviously _has_ to do that, because in order to know whether you've 
> changed it, it needs to now compare it to the original.

I must be missing something here ...

If the stat shows a possible change, then you shouldn't have to open the
original version to determine if it really changed - just compute the
SHA1 of the new file, and see if that changed from the original SHA1.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
