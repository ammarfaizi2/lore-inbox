Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280035AbRLQOl4>; Mon, 17 Dec 2001 09:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279556AbRLQOlh>; Mon, 17 Dec 2001 09:41:37 -0500
Received: from ns.suse.de ([213.95.15.193]:273 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279307AbRLQOl2>;
	Mon, 17 Dec 2001 09:41:28 -0500
Date: Mon, 17 Dec 2001 15:41:24 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <Pine.LNX.4.33.0112171523460.28670-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.33.0112171537140.28670-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Dave Jones wrote:

> > Nah. I hit this one myself just half an hour after 1 fired off my last
> > mail.
> > 'fattr' patch updated yet again...
> Seems to do the trick. fsx has been running for about half hour so far
> with no problems.

Here's an interesting one.. Run two instances of fsx together
using the same test file..

./fsx -c666 /mnt/nfs/noodles/test
./fsx -c667 /mnt/nfs/noodles/test

I typoed the 2nd line (and meant to do 'test2' concurrently)
Some kind of file locking problem?

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

