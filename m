Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbTJJPzk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbTJJPzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:55:39 -0400
Received: from snerble.cc.purdue.edu ([128.210.189.21]:48596 "EHLO
	snerble.fmepnet.org") by vger.kernel.org with ESMTP id S262979AbTJJPzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:55:17 -0400
From: Michael Shuey <shuey@fmepnet.org>
Reply-To: shuey@fmepnet.org
Organization: fmepnet.org
To: trond.myklebust@fys.uio.no
Subject: Re: Misc NFSv4 (was Re: statfs() / statvfs() syscall ballsup...)
Date: Fri, 10 Oct 2003 10:55:10 -0500
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org> <20031010143553.GA28795@mail.shareable.org> <16262.53512.249701.158271@charged.uio.no>
In-Reply-To: <16262.53512.249701.158271@charged.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310101055.12626.shuey@fmepnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 October 2003 10:32 am, Trond Myklebust wrote:
> The client implementation in 2.6.0 is still lacking several important
> features, including locking, ACLs, delegation support and recovery of
> state (in case of server reboot or network partitions). I'm hoping
> Andrew/Linus will allow me to send updates once the early 2.6.x
> codefreeze period is over.

How about other features?  In particular, do the client/server do 
authentication (krb5? lipkey/spkm3?), integrity and privacy?

Also, are any patches on Citi's site useful anymore?  I see patches for 
2.6.0-test1, but nothing more recent.  Have they been folded into the main 
tree?

> That said, I definitely encourage people to test out the existing code
> for stability, and I will be offering an 'NFS_ALL' series with those
> features that are missing from the main tree as and when I judge they
> are approaching release quality.

Neato!  Those of us with hordes of machines using Linux's NFS appreciate the 
extra effort.

-- 
Mike Shuey
