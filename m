Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267713AbUIKIIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267713AbUIKIIz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 04:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267759AbUIKIIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 04:08:54 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:54425 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267713AbUIKIIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 04:08:53 -0400
Date: Sat, 11 Sep 2004 01:08:08 -0700
From: Paul Jackson <pj@sgi.com>
To: Simon Derr <simon.derr@bull.net>
Cc: simon.derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] 1/2 Additional cpuset features
Message-Id: <20040911010808.2b283c9a.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409101036090.2891@daphne.frec.bull.fr>
References: <Pine.LNX.4.58.0409101036090.2891@daphne.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good luck with these patches, Simon, though I do not support them.

For the record, I was the one most responsible for removing these two
patches:

 1) auto task migration on cpuset change, and
 2) cpuset relative CPU/Memory numbering.

I continue to think that these can be done just as well in user space. 
A bit better in user space actually, as the locking for (1) is easier
from user space, and the opportunity for more flexible adaption to
different renumbering needs that (2) attempts is easier from user space.

But if others find these worth persuing in kernel space, so be it.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
