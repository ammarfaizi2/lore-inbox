Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVDJDl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVDJDl4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 23:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVDJDl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 23:41:56 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:2017 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261427AbVDJDlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 23:41:55 -0400
Date: Sat, 9 Apr 2005 20:41:33 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ross@jose.lug.udel.edu, cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
Message-Id: <20050409204133.60b1b40d.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0504090916550.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<20050408041341.GA8720@taniwha.stupidest.org>
	<Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
	<20050408071720.GA23128@jose.lug.udel.edu>
	<Pine.LNX.4.58.0504080758420.28951@ppc970.osdl.org>
	<20050409085017.7edf2c9a.pj@engr.sgi.com>
	<Pine.LNX.4.58.0504090916550.1267@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> Almost everything
> else keeps the <sha1> in the ASCII hexadecimal representation, and I
> should have done that here too. Why? Not because it's a <sha1> - hey, the 
> binary representation is certainly denser and equivalent

Since the size of <compressed> ASCII sha1's is only about 18% larger
than the size of the same number of binary sha1's <compressed or not>, I
don't see you gain much from the binary.

I cast my non-existent vote for making the sha1 ascii - while you still can ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
