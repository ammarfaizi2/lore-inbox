Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290613AbSBFPXu>; Wed, 6 Feb 2002 10:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290614AbSBFPXi>; Wed, 6 Feb 2002 10:23:38 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:24324
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S290613AbSBFPXY>; Wed, 6 Feb 2002 10:23:24 -0500
Subject: Re: 2.4.18-pre8 + 2.4.17-pre8-ac3 + rmap12c + XFS Results
From: Shawn Starr <spstarr@sh0n.net>
To: Dan Chen <crimsun@email.unc.edu>
Cc: Linux <linux-kernel@vger.kernel.org>
In-Reply-To: <20020206091338.GA670@opeth.ath.cx>
In-Reply-To: <Pine.LNX.4.40.0202060213380.395-100000@coredump.sh0n.net> 
	<20020206091338.GA670@opeth.ath.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 06 Feb 2002 10:26:06 -0500
Message-Id: <1013009193.14610.0.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I'll apply this diff to my tree when I get home today. 

On Wed, 2002-02-06 at 04:13, Dan Chen wrote:
> On Wed, Feb 06, 2002 at 02:17:28AM -0500, Shawn Starr wrote:
> > I'm happy to say that rmap12c has huge preformance improvements over
> > rmap11c with my Pentium 200Mhz w/64MB ram.
> > 
> > Some of the differences:
> > 
> > rmap11c: slow redrawing of mozilla, mouse hangs, system sluggishness.
> > 
> > rmap12c: no slow redrawing UNLESS heavy I/O & swapping is occuring. System
>                                     ^^^^^^^^^^^^^^^^^^^^
> Would you try the ChangeSet 1.188, specifically the one for
> fs/buffer.c@1.52?
> http://linuxvm.bkbits.net:8088/vm-2.4/diffs/fs/buffer.c@1.52?nav=index.html|ChangeSet@-2d|cset@1.188
> 
> I agree that rmap12c + the above fix has noticeable improvements over
> the 11 series. I'll be pushing some numbers out later today.
> 
> -- 
> Dan Chen                 crimsun@email.unc.edu
> GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc


