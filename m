Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280807AbRKTBFy>; Mon, 19 Nov 2001 20:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280809AbRKTBFp>; Mon, 19 Nov 2001 20:05:45 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:46986 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S280807AbRKTBFc>; Mon, 19 Nov 2001 20:05:32 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alexander Viro <viro@math.psu.edu>
Date: Tue, 20 Nov 2001 12:06:01 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15353.44153.411799.108320@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Devlinks.  Code.  (Dcache abuse?)
In-Reply-To: message from Alexander Viro on Monday November 19
In-Reply-To: <15352.60223.1832.897635@notabene.cse.unsw.edu.au>
	<Pine.GSO.4.21.0111190624370.17210-100000@weyl.math.psu.edu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 19, viro@math.psu.edu wrote:
> 
> 
> On Mon, 19 Nov 2001, Neil Brown wrote:
> > I was thinking:
> > 
> >    devid/9005/00cf/0
> 
> And that you would call a text?  We are just trading two numbers for
> a bunch of them.

I disagree with the word "just".  A bunch of numbers, with no fixed
limit, is *much* more usable than that 17 bits we now have, or the 33
bits that we might get.

Look at the naming used for MIBs, as in SNMP.  It's just a list of
numbers, but it is very flexable and expressive.  Not that I think
mib names are elegant.  But they are expressive.  Structure needs to
be imposed to get elegance.

So even if it were just a bunch of numbers it would be significantly
better.  Allowing words is just icing on the cake.

>                   Better yet, how about a driver that treats several
> cards as identical?

What is so interesting about that.  I'm not really interested in what
driver is being used.  Just in what the hardware is, and what the
interface is.  modutils might care about the driver, but devlinks
don't.

NeilBrown
