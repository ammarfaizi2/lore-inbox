Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281058AbRLDQuy>; Tue, 4 Dec 2001 11:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281184AbRLDQt4>; Tue, 4 Dec 2001 11:49:56 -0500
Received: from pc-62-30-67-59-az.blueyonder.co.uk ([62.30.67.59]:61166 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S281058AbRLDQsn>; Tue, 4 Dec 2001 11:48:43 -0500
Date: Tue, 4 Dec 2001 16:46:05 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Andrew Morton <akpm@zip.com.au>
Cc: Dave Jones <davej@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <20011204164605.C28839@kushida.jlokier.co.uk>
In-Reply-To: <3C0A9BD7.47473324@zip.com.au> <Pine.LNX.4.33.0112022236150.26183-100000@Appserv.suse.de> <3C0AA6D6.30BE0BF6@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0AA6D6.30BE0BF6@zip.com.au>; from akpm@zip.com.au on Sun, Dec 02, 2001 at 02:10:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> > 128 kernel threads sitting around waiting for a problem that
> > rarely happens seems a little.. strange. (for want of a better word).
> 
> I've kinda lost the plot on ksoftirqd.  Never really understood
> why a thread was needed for this, nor why it runs at nice +20.
> But things seem to be working now.

Me no idea either.  It wasn't to work around the problem of losing
softirqs on syscall return was it?  Because there was a patch for that
in the low-latency set that fixed that without a thread, and without a
delay...

-- Jamie
