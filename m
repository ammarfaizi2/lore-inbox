Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129261AbRBWSR0>; Fri, 23 Feb 2001 13:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131535AbRBWSRP>; Fri, 23 Feb 2001 13:17:15 -0500
Received: from p3EE3C901.dip.t-dialin.net ([62.227.201.1]:45316 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129261AbRBWSQy>; Fri, 23 Feb 2001 13:16:54 -0500
Date: Fri, 23 Feb 2001 18:53:49 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: TESTERS PLEASE - improvements to knfsd for 2.4.2
Message-ID: <20010223185349.G7589@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <14996.37528.486223.118752@notabene.cse.unsw.edu.au> <9737e4$o35$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9737e4$o35$1@forge.intermeta.de>; from hps@tanstaafl.de on Thu, Feb 22, 2001 at 14:24:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2001, Henning P. Schmiedehausen wrote:

> neilb@cse.unsw.edu.au (Neil Brown) writes:
> 
> > I am looking forward to seeing lots of downloads and absolutely no
> > problem reports.... but is seems unlikely.
> 
> > Alan Cox has suggested that these changes may not be appropriate for
> > 2.4, so we might have to wait for 2.5 to see them on kernel.org, but
> > we don't have to wait till then to find the bugs.
> 
> Oh, please not again a stable kernel series with NFS problems, we're
> locked in for ages. 2.2 was bad enough up to 2.2.18. We have ReiserFS
> in 2.4.1 (and not in 2.4.0), could we _please_ get NFS-exportable
> ReiserFS in 2.4.4 or 2.4.5?

2.2.18 is still broken, won't play NFSv3 games with FreeBSD clients.
Neil has posted a patch here which fixes this.

And, ReiserFS messes NFSv3 up, I'm currently switching all my boxes back
to ext2, because I'm really pissed. And if these NFS annoyances
continue, it might be about time to try FreeBSD or NetBSD. Journalling
file systems which hide their files away for maintainer incompetence and
uncoordinated patching around don't buy us anything except continued
"don't use Linux as NFS server" reputation.
