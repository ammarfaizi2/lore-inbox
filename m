Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbTJFUjY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 16:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTJFUjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 16:39:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:52373 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261299AbTJFUjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 16:39:18 -0400
Subject: Re: Linux 2.6.0-test6 (compile statistics)
From: John Cherry <cherry@osdl.org>
To: Jesper Juhl <jju@dif.dk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0309291937350.12255@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
	 <1064853054.914.5.camel@cherrytest.pdx.osdl.net>
	 <Pine.LNX.4.56.0309291937350.12255@jju_lnx.backbone.dif.dk>
Content-Type: text/plain
Organization: 
Message-Id: <1065472754.21161.26.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 06 Oct 2003 13:39:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-29 at 10:44, Jesper Juhl wrote:
[snip]
> 
> I was wondering if there would be any point in doing these builds with
> "allnoconfig" as well?
> Could this possibly flush out some warnings/errors that only occur when
> something is left out?
> 
> 

The compile regressions now build with allnoconfig as well for both
Linus' tree and Andrew's tree.  Check out...

http://developer.osdl.org/cherry/compile/

BTW, the latest compile stats for test6-mm3 and test6-mm4 are:

Kernel version: 2.6.0-test6-mm4
Kernel build: 
   Making bzImage (defconfig): 0 warnings, 0 errors
   Making modules (defconfig): 0 warnings, 0 errors
   Making bzImage (allnoconfig): 1 warnings, 0 errors
   Making bzImage (allyesconfig): 179 warnings, 1 errors
   Making modules (allyesconfig): 9 warnings, 0 errors
   Making bzImage (allmodconfig): 3 warnings, 0 errors
   Making modules (allmodconfig): 234 warnings, 1 errors

Kernel version: 2.6.0-test6-mm3
Kernel build: 
   Making bzImage (defconfig): 0 warnings, 0 errors
   Making modules (defconfig): 0 warnings, 0 errors
   Making bzImage (allnoconfig): 1 warnings, 0 errors
   Making bzImage (allyesconfig): 178 warnings, 1 errors
   Making modules (allyesconfig): 9 warnings, 0 errors
   Making bzImage (allmodconfig): 3 warnings, 0 errors
   Making modules (allmodconfig): 252 warnings, 1 errors


John

