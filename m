Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129849AbRBWUFV>; Fri, 23 Feb 2001 15:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129975AbRBWUFL>; Fri, 23 Feb 2001 15:05:11 -0500
Received: from pipt.oz.cc.utah.edu ([155.99.2.7]:22927 "EHLO
	pipt.oz.cc.utah.edu") by vger.kernel.org with ESMTP
	id <S129849AbRBWUE5>; Fri, 23 Feb 2001 15:04:57 -0500
Date: Fri, 23 Feb 2001 13:04:49 -0700 (MST)
From: james rich <james.rich@m.cc.utah.edu>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: TESTERS PLEASE - improvements to knfsd for 2.4.2
In-Reply-To: <20010223185349.G7589@emma1.emma.line.org>
Message-ID: <Pine.GSO.4.05.10102231302480.15426-100000@pipt.oz.cc.utah.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2001, Matthias Andree wrote:

> On Thu, 22 Feb 2001, Henning P. Schmiedehausen wrote:
> 
> > neilb@cse.unsw.edu.au (Neil Brown) writes:
> > 
> > Oh, please not again a stable kernel series with NFS problems, we're
> > locked in for ages. 2.2 was bad enough up to 2.2.18. We have ReiserFS
> > in 2.4.1 (and not in 2.4.0), could we _please_ get NFS-exportable
> > ReiserFS in 2.4.4 or 2.4.5?
> 
> 2.2.18 is still broken, won't play NFSv3 games with FreeBSD clients.
> Neil has posted a patch here which fixes this.
> 
> And, ReiserFS messes NFSv3 up, I'm currently switching all my boxes back
> to ext2, because I'm really pissed. And if these NFS annoyances
> continue, it might be about time to try FreeBSD or NetBSD. Journalling
> file systems which hide their files away for maintainer incompetence and
> uncoordinated patching around don't buy us anything except continued
> "don't use Linux as NFS server" reputation.

If you need journaled file systems and NFS I have been using XFS and it
seems to be fine when exported over NFS (Yes I know it isn't in the main
kernel - hopefully that changes soon).

James Rich
james.rich@m.cc.utah.edu

