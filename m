Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264315AbUEIJLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264315AbUEIJLP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 05:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbUEIJLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 05:11:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:4577 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264315AbUEIJLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 05:11:13 -0400
X-Authenticated: #20450766
Date: Sun, 9 May 2004 11:10:30 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, <dipankar@in.ibm.com>,
       <manfred@colorfullife.com>, <davej@redhat.com>, <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <maneesh@in.ibm.com>
Subject: Re: dentry bloat.
In-Reply-To: <Pine.LNX.4.58.0405082143340.1592@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44.0405091058300.2106-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2004, Linus Torvalds wrote:

>    1:     5.04 % (    5.04 % cum -- 2246)
>    2:     5.19 % (   10.23 % cum -- 2312)

Ok, risking to state the obvious - it was intentional to count "."s and
".."s, wasn't it? Just this makes it a bit non-trivial to compare this
statistics with Andrew's.

>   23:     0.14 % (   92.64 % cum -- 63)
>
> ie we've reached 92% of all names with 24-byte inline thing.

[OT, educational]: Do "." and ".." actually take dentries?

Thanks
Guennadi
---
Guennadi Liakhovetski



