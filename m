Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282812AbRLOQwn>; Sat, 15 Dec 2001 11:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282814AbRLOQwd>; Sat, 15 Dec 2001 11:52:33 -0500
Received: from ns.suse.de ([213.95.15.193]:13325 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282812AbRLOQwT>;
	Sat, 15 Dec 2001 11:52:19 -0500
Date: Sat, 15 Dec 2001 17:52:18 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: <trond.myklebust@fys.uio.no>
Subject: More fun with fsx.
In-Reply-To: <20011215154029.A3954@suse.de>
Message-ID: <Pine.LNX.4.33.0112151745230.1425-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2001, Dave Jones wrote:

> The changes to make it work are trivial, and are at
> http://www.codemonkey.org.uk/cruft/fsx-linux.c
> (non-existant include & expected mmap() behaviour differences)

Whilst waiting for the local fs tests to finish/progress I did
a quick test with nfs. It dies after a while with an io error.

You can skip over the boring part and go straight to the interesting
failure case by using the options -c1234 -b 48870
Should happen quite quickly after that.

Full log of the failcase is at
http://www.codemonkey.org.uk/cruft/nfs-fsx.txt


regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

