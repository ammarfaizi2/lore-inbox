Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310648AbSCHByq>; Thu, 7 Mar 2002 20:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310646AbSCHBy1>; Thu, 7 Mar 2002 20:54:27 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:2485 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S310640AbSCHByK>; Thu, 7 Mar 2002 20:54:10 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@zip.com.au>
Date: Fri, 8 Mar 2002 12:48:11 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15496.6235.723025.422239@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
In-Reply-To: message from Andrew Morton on Thursday March 7
In-Reply-To: <3C87FD12.8060800@greshamstorage.com>
	<Pine.LNX.4.44L.0203072057510.2181-100000@imladris.surriel.com>
	<3C880541.E04EFAB3@zip.com.au>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday March 7, akpm@zip.com.au wrote:
> 
> Current tkdiff is in fact very good at this.  So integration
> with that may suit.

I find the e-diff mode in emacs quite good too.  I had a quick look at
tkdiff and it seems to be much the same sort of idea.

> 
> The problem I find is that I often want to take (file1+patch) -> file2,
> when I don't have file1.  But merge tools want to take (file1|file2) -> file3.
> I haven't seen a graphical tool which helps you to wiggle a patch into
> a file.

If your saying what I think you're saying, I completely agree.
I often run "patch" and it drops some chunk because it doesn't match,
and it turns out that the miss-match is just one or two lines in a
chunk that could be very big.
I would like a tool (actually an emacs mode) that would show me exactly
why a patch fails, and allow me to edit bits until it fits, and then
apply it.  I assume that is what you mean by "wiggle a patch into a file".

> 
> This is a bit extreme perhaps but I'm currently working code which
> consists of twelve changesets against 100 files.  Many of those
> files are changed by multiple changesets.  So two things:
> 
> 1: If I have two changesets applied to a file, and I make a change to
>    that file, which changeset is it to be associated with?
> 
How about an editor which, when you view a file, gives you also a
little window onto that file for every other version in your current
series of change sets.
When you make a change it gets propagated forwards.  To edit a
different changeset you just choose the right little window.

So many ideas... so little time....

NeilBrown
