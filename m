Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284956AbRLQBhv>; Sun, 16 Dec 2001 20:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284955AbRLQBhl>; Sun, 16 Dec 2001 20:37:41 -0500
Received: from ns.suse.de ([213.95.15.193]:36622 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284956AbRLQBh3>;
	Sun, 16 Dec 2001 20:37:29 -0500
Date: Mon, 17 Dec 2001 02:37:25 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <15389.19300.179304.433697@charged.uio.no>
Message-ID: <Pine.LNX.4.33.0112170236290.29678-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Trond Myklebust wrote:

> No. I think I've got it. You are running NFSv2 (I assumed v3) and I'll
> bet that if you look in your syslog, you'll see the error message
> NFS: Odd RPC header size in read reply:
> Am I right?

The only stuff that looks related is...

call_verify: server accept status: 2
call_verify: server accept status: 2
call_verify: server accept status: 2
RPC: garbage, exit EIO
nfs_get_root: getattr error = 5


> This is a bug that was fixed ages ago in the NFSv3 code. I've updated
> the 'fattr' patch yet again...

Ok, I'll give it a try soon..

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

