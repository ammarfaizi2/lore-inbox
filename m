Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSDLHKg>; Fri, 12 Apr 2002 03:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313313AbSDLHKf>; Fri, 12 Apr 2002 03:10:35 -0400
Received: from mons.uio.no ([129.240.130.14]:22450 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S313087AbSDLHKe>;
	Fri, 12 Apr 2002 03:10:34 -0400
To: Daniel Forrest <forrest@lmcg.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lockd hanging
In-Reply-To: <200204112333.SAA22343@radium.lmcg.wisc.edu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 12 Apr 2002 09:10:24 +0200
Message-ID: <shsk7rd8k9r.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Daniel Forrest <forrest@lmcg.wisc.edu> writes:

     > This is my first post to this list, I'll try to be brief.
     > Kernel version 2.4.18.

     > Problem: under heavy load (i.e. >32 client machines
     > locking/unlocking the same NFS mounted file repeatedly) lockd
     > hangs (sometimes hanging the local file system with it) and the
     > server must be rebooted.

     > I have discovered a basic flaw in the lockd code and have
     > patched it to work correctly.  Is there an individual who is
     > "responsible" for the lockd code whom I can correspond with to
     > discuss the flaws I have found, the solutions I have devised,
     > and how to get this patch into general circulation.

There is no single maintainer of the lockd code. Neil Brown and I tend
to share responsibility for pushing these patches to Linus & Marcelo.

FYI: You will find a number of people who would be interested in
discussing this on the NFS mail list NFS@lists.sourceforge.net
(although a lot of us are subscribed to linux kernel too). Please just
trot out your patches on either of these lists, and show us what
you've found 8-)

Cheers,
  Trond
