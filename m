Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281077AbRLQQQJ>; Mon, 17 Dec 2001 11:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281116AbRLQQPx>; Mon, 17 Dec 2001 11:15:53 -0500
Received: from ns.suse.de ([213.95.15.193]:40204 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281077AbRLQQPj>;
	Mon, 17 Dec 2001 11:15:39 -0500
Date: Mon, 17 Dec 2001 17:15:38 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <15390.6164.233273.513319@charged.uio.no>
Message-ID: <Pine.LNX.4.33.0112171714550.28670-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Trond Myklebust wrote:

> > Some kind of file locking problem?
> Is that supposed to work? That gives 2 programs messing with the same
> file 'test', but since the variable 'good_buf' is not shared, I'd
> expect failure.

*nod*, this is repeatable on all fs's, so it looks like a shortcoming
of fsx rather than a fs failure.

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

