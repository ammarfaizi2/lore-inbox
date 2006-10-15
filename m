Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422673AbWJOSJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422673AbWJOSJY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 14:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422676AbWJOSJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 14:09:24 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:34809 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1422673AbWJOSJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 14:09:23 -0400
Date: Sun, 15 Oct 2006 11:10:39 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Casey Dahlin <cjdahlin@ncsu.edu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Readability improvement of open_exec()
Message-Id: <20061015111039.7fb80045.randy.dunlap@oracle.com>
In-Reply-To: <1160707333.3230.14.camel@localhost.localdomain>
References: <1160707333.3230.14.camel@localhost.localdomain>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 22:42:13 -0400 Casey Dahlin wrote:

> A fairly trivial patch that simply improves the readability of the
> open_exec() function. It no longer executes primarily inside nested ifs
> or has 5 levels of indentation :) Logically it should be no different
> from the original. Patch applies to stock 2.6.18 kernel.
> 
> 
> Signed-off-by: Casey Dahlin <cjdahlin@ncsu.edu>
> 
> ---
> 
> diff -up exec.c.bak exec.c
> --- exec.c.bak	2006-09-19 23:42:06.000000000 -0400
> +++ exec.c	2006-10-12 21:42:01.000000000 -0400

Please use diff and diffstat as suggested in
Documentation/SubmittingPatches, and do so from the top-level
directory of the kernel source tree, so that the full
path/file names are used in the diff lines.

---
~Randy
