Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVDJSzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVDJSzu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVDJSyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:54:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62689 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261572AbVDJSw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:52:28 -0400
Date: Sun, 10 Apr 2005 11:50:55 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: junkio@cox.net, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-Id: <20050410115055.2a6c26e8.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	<20050409200709.GC3451@pasky.ji.cz>
	<Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
	<7vhdifcbmo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
>  It's a filesystem - although a
> fairly strange one.

Ah ha - that explains the read-tree and write-tree names.

The read-tree pulls stuff out of this file system into
your working files, clobbering local edits.  This is like
the read(2) system call, which clobbers stuff in your
read buffer.

The write-tree pushes stuff down into the file system,
just like write(2) pushes data into the kernel.

I was getting all kind of frustrated yesterday trying
to use Linus's git commands, coming at these names with my
SCM hat on.

That way of thinking really doesn't work well here.

I will have to look more closely at pasky's GIT toolkit
if I want to see an SCM style interface.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
