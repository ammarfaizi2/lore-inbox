Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVDJCHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVDJCHk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 22:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVDJCHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 22:07:40 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:56449 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261191AbVDJCHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 22:07:34 -0400
Date: Sat, 9 Apr 2005 19:07:15 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: pasky@ucw.cz, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-Id: <20050409190715.679e9023.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	<20050409200709.GC3451@pasky.ji.cz>
	<Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> Damn, that's painful. I suspect I will have to change the format somehow.

The sha1 (ascii) digests for 16817 files take:

	689497 bytes before compression
	397475 bytes after minigzip

The pathnames, relative to top of tree, for these 16817
files take:

	503983 bytes before compression
	 85786 bytes after minigzip compression

I doubt any fancifying up of the pathname storage will gain much.

However going from binary to ascii sha1 digest might help (compresses
better, I suspect - I'll have to write a few lines of code to see).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
