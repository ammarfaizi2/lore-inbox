Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314852AbSDVWUD>; Mon, 22 Apr 2002 18:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314853AbSDVWUC>; Mon, 22 Apr 2002 18:20:02 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:33798 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S314852AbSDVWUB>; Mon, 22 Apr 2002 18:20:01 -0400
Date: Tue, 23 Apr 2002 00:19:53 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS in the main kernel
Message-ID: <20020422221952.GB10813@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3CC427F4.12C40426@fnal.gov> <aa1f9o$519$1@picard.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2002, Wichert Akkerman wrote:

> In article <3CC427F4.12C40426@fnal.gov>,
> Dan Yocum  <yocum@fnal.gov> wrote:
> >I know it's been discussed to death, but I am making a formal request to you
> >to include XFS in the main kernel.  We (The Sloan Digital Sky Survey) and
> >many, many other groups here at Fermilab would be very happy to have this in
> >the main tree.  
> 
> Has XFS been proven to be completely stable and POSIX complient in its
> behaviour? The reason I am asking is that XFS seems to be a fairly common
> factor for segfault bugreports in dpkg. The problems are rare enough (and
> never reproducable) so I can't prove this but it does leave me wondering.

Is there a test suite that checks POSIX (or better yet, SUS v3)
compliance of a file system? That might prove useful, although I'm well
aware it'd probably require some brains (and kernel modules) to check
consistency guarantees. But apart from that, things like "truncate to
zero length does not change the mtime of a file" (fixed in ReiserFS only
some weeks ago) might get caught that way.
