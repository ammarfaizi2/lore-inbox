Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbTCCPx4>; Mon, 3 Mar 2003 10:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266161AbTCCPx4>; Mon, 3 Mar 2003 10:53:56 -0500
Received: from angband.namesys.com ([212.16.7.85]:33665 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265857AbTCCPxy>; Mon, 3 Mar 2003 10:53:54 -0500
Date: Mon, 3 Mar 2003 19:04:17 +0300
From: Oleg Drokin <green@namesys.com>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       mason@suse.com, trond.myklebust@fys.uio.no, jaharkes@cs.cmu.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 iget5_locked port attempt to 2.4
Message-ID: <20030303190417.C4513@namesys.com>
References: <20030303183838.B4513@namesys.com> <Pine.SOL.3.96.1030303155239.1630A-100000@virgo.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.3.96.1030303155239.1630A-100000@virgo.cus.cam.ac.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Mar 03, 2003 at 03:57:19PM +0000, Anton Altaparmakov wrote:
> > > >    It's me again, I basically got no reply for this iget5_locked patch
> > > >    I have now. Would there be any objections if I try push it to Marcelo
> > > >    tomorrow? ;)
> > > I just binned it. Certainly its not the kind of stuff I want to test in -ac, 
> > > too many VFS changes outside reiserfs
> > Andrew Morton said "iget5_locked() looks simple enough, and as far as I can
> > tell does not change any existing code - it just adds new stuff.",
> > also this code (in its 2.5 incarnation) was tested in 2.5 for long time already.
> > Also it fixes real bug (and while I have another reiserfs-only fix for the bug,
> > it is fairly inelegant).
> I agree it should go into 2.4 but I don't think the patches you are
> submitting should go in. From what I can see they are an older version
> compared to what actually went into 2.5. (I am basing this on the comments

What I am submitting is just changesets 1.373.172.1..1.373.172.6 from
2.5 bk tree. So these patches are what went into 2.5 (plus all the bugs I
have made during adapting these to 2.4, of course).

> to the functions rather than thorough code comparisons but I don't have
> time to look at it more in depth atm.) Why don't you use the actual 2.5
> code and make new patches or at least make use of the patches that finally
> went into 2.5?

Looking at the changelog, it seems much later on there were ifind_fast() and ifind()
additions to this code, but I was not sure I should take these too.
I can though, if people think that would be useful.

Bye,
    Oleg
