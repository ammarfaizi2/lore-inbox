Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbTEARRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 13:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbTEARRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 13:17:33 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:26630 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S261462AbTEARRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 13:17:32 -0400
To: Larry McVoy <lm@bitmover.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, rmoser <mlmoser@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel source tree splitting
References: <200304301946130000.01139CC8@smtp.comcast.net>
	<20030430172102.69e13ce9.rddunlap@osdl.org>
	<20030501005224.GA8676@work.bitmover.com>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20030501005224.GA8676@work.bitmover.com>
Date: 01 May 2003 13:28:16 -0400
Message-ID: <m3n0i6zidr.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Larry" == Larry McVoy <lm@bitmover.com> writes:

Larry> It's a very little known fact but if you are in an RCS
Larry> or SCCS (and BK looks like SCCS to make) source tree and the
Larry> files are not checked out, you can just say

Larry> 	make

Larry> and make will look for a makefile, if there isn't one but there
Larry> is a SCCS/s.[Mm]akefile it will check it out, look at the
Larry> dependencies and start checking those out and keep doing it to
Larry> satisfy the target.

That has never worked for me with Linus' or Marcello's trees.  It
always falls down at some point or other.  

Usually it fails looking for something under include, 2.5 also dies
in make oldconfig.

-JimC

