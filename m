Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265195AbSJRQYk>; Fri, 18 Oct 2002 12:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbSJRQYk>; Fri, 18 Oct 2002 12:24:40 -0400
Received: from tsv.sws.net.au ([203.36.46.2]:10506 "EHLO tsv.sws.net.au")
	by vger.kernel.org with ESMTP id <S265195AbSJRQYj>;
	Fri, 18 Oct 2002 12:24:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Christoph Hellwig <hch@infradead.org>, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] remove sys_security
Date: Fri, 18 Oct 2002 18:30:28 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
References: <Pine.GSO.4.21.0210180309540.18575-100000@weyl.math.psu.edu> <200210181514.g9IFEErG006526@turing-police.cc.vt.edu> <20021018161828.A5523@infradead.org>
In-Reply-To: <20021018161828.A5523@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210181830.28354.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002 17:18, Christoph Hellwig wrote:
> > The part you're missing here is that the "fuzzy buzzword mechanism" is
> > deployable *NOW*, and will provide *real benefits* *NOW*, rather than
> > having to wait for the 2.7 or 3.1 or whatever kernel.
>
> By messing up the kernel.  Note that I don't want to steal you your
> code - deploy it if you want, but don't harm the mainline kernel with it.

So how does it harm the mainline kernel to have a system call reserved for LSM 
and then not allow anything in the mainline kernel that uses it?  Then we can 
deploy modules using the current LSM design without harming the mainline 
kernel.

The only code that we really want to see in the mainline kernel is the hooks 
for permission checks.  Personally I would not mind if no security module 
ever gets included in Linus' source tree.


Disclaimer:  This message is my own opinion, even if I was part of "team LSM" 
I would not be representing them in this issue.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

