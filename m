Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266564AbUHINVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266564AbUHINVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 09:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266565AbUHINVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 09:21:23 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:62642 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266564AbUHINVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 09:21:19 -0400
Date: Mon, 9 Aug 2004 06:21:27 -0700
From: Paul Jackson <pj@sgi.com>
To: =?ISO-8859-1?Q?Mari=E1n?= Tomko <macros@lmxmail.sk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: howto apply supermount patch only....
Message-Id: <20040809062127.46acc804.pj@sgi.com>
In-Reply-To: <411734E1.5070508@lmxmail.sk>
References: <411734E1.5070508@lmxmail.sk>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> patch: **** Only garbage was found in the patch input.

Usually this means that your patch file, supermount-ng204.diff in the
case you describe, doesn't contain an actual, correctly formatted,
patch.

The most common format for patch files has some commentary in free form
text, followed by one or more patches, which are the output of a diff
command such as "diff -Naurp".  If you look on this lkml email list for
posts that have a Subject starting with "[PATCH]" or "[patch]", you will
find many examples of such.

If your supermount-ng204.diff file is not of this format, then the
'patch' command will complain in ways such as you report.  When that
happens, you have to figure out why your patch file is bad - perhaps it
got mangled during your download and copy operations, or perhaps it
isn't a proper patch to begin with.  You will have to trace that down.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
