Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317755AbSGZOCg>; Fri, 26 Jul 2002 10:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317756AbSGZOCg>; Fri, 26 Jul 2002 10:02:36 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:13244 "EHLO
	shaggy.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S317755AbSGZOCg>; Fri, 26 Jul 2002 10:02:36 -0400
From: Dave Kleikamp <shaggy@austin.ibm.com>
Message-Id: <200207261404.g6QE4o520741@shaggy.austin.ibm.com>
Subject: Re: JFS errors
To: axel@hh59.org
Date: Fri, 26 Jul 2002 09:04:50 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org, jfs-discussion@www-124.southbury.usf.ibm.com
In-Reply-To: <20020725222747.GB18216@neon.hh59.org> from "axel@hh59.org" at Jul 26, 2002 12:27:47 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, it's built with JFS_DEBUG. That was the first thing I compiled into a
> new kernel when I first encountered this.

I'll take another look at the oops.  My initial thought was that if I was
right in my assumptions, a dereference in an ASSERT statement would have
caused a trap slightly earlier than the one you hit.  Without debug, the
ASSERT is compiled out.

> How can it help you?

If it's already on, it won't provide any more help.  There was just a
chance that if it wasn't on, it might have caught something earlier.

> Shall I provide info from /proc/fs/jfs after oops
> occured?

I doubt anything there would be useful.

> Oops itself I have to handcopy each time. Hard work! ;) But I guess I can
> access /proc tree.

The oops was helpful, and I'll need to take a closer look at the code.  I'll
let you know if I want you to try anything else.

Thanks for the feedback.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center
