Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313730AbSDUS0U>; Sun, 21 Apr 2002 14:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313722AbSDUSZD>; Sun, 21 Apr 2002 14:25:03 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:50853 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S313717AbSDUSYw>;
	Sun, 21 Apr 2002 14:24:52 -0400
Date: Sun, 21 Apr 2002 14:24:47 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Larry McVoy <lm@work.bitmover.com>, Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org,
        Wayne Scott <wscott@work.bitmover.com>
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-ID: <20020421142447.G8142@havoc.gtf.org>
In-Reply-To: <20020421131354.C4479@havoc.gtf.org> <20020421102339.E10525@work.bitmover.com> <20020421133225.F4479@havoc.gtf.org> <20020421103923.I10525@work.bitmover.com> <20020421134500.A7828@havoc.gtf.org> <20020421104725.K10525@work.bitmover.com> <20020421134955.C7828@havoc.gtf.org> <20020421105706.M10525@work.bitmover.com> <20020421140753.C8142@havoc.gtf.org> <20020421111450.P10525@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 11:14:50AM -0700, Larry McVoy wrote:
> On Sun, Apr 21, 2002 at 02:07:53PM -0400, Jeff Garzik wrote:
> > Triggers are completely useless for "show me what the next-to-last
> > 'bk pull' downloaded, in GNU patch style."  

> All you need to do is save the starting and ending cset revs as keys,
> and then send those into bk export -tpatch.  So a trigger which saved
> top of trunk on a stack is all you need, the rest is a tiny amount of
> perl/shell.  Write it, send it to me, if people like it, we'll roll it
> into the mainline release.

In order to implement multiple 'bk undo' stack as you described, you
need to store or deduce that info anyway.  If I wrote it, wouldn't I be
duplicating work (or doing work for you)?

	Jeff



