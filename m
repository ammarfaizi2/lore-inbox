Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTHaVFi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 17:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTHaVFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 17:05:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:60289 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262674AbTHaVFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 17:05:38 -0400
Date: Sun, 31 Aug 2003 14:05:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Erik Andersen <andersen@codepoet.org>
cc: Andrew Morton <akpm@osdl.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       <linux-kernel@vger.kernel.org>, <jun.nakajima@intel.com>
Subject: Re: [PATCHSET][2.6-test4][0/6]Support for HPET based timer - Take
 2
In-Reply-To: <20030829210335.GA3150@codepoet.org>
Message-ID: <Pine.LNX.4.44.0308311404430.1581-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 29 Aug 2003, Erik Andersen wrote:
> 
> gcc then generates code calling __udivdi3 and __umoddi3.  Since
> the kernel does not provide these, people keep reinventing them.
> Perhaps it is time to kill off do_div and all its little friends
> and simply copy __udivdi3 and __umoddi3 from libgcc.....

No. do_div() does _nothing_ like __udivdi3/__umoddi3.

Read the documentation.


		Linus

