Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287734AbSAIQFQ>; Wed, 9 Jan 2002 11:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287720AbSAIQE5>; Wed, 9 Jan 2002 11:04:57 -0500
Received: from pat.uio.no ([129.240.130.16]:64995 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S287743AbSAIQEi>;
	Wed, 9 Jan 2002 11:04:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15420.27148.80553.930142@charged.uio.no>
Date: Wed, 9 Jan 2002 17:04:28 +0100
To: Birger Lammering <b.lammering@science-computing.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: more tcpdumpinfo for nfs3 problem: aix-server
In-Reply-To: <15420.23686.566719.128899@stderr.science-computing.de>
In-Reply-To: <15418.55750.210978.737165@stderr.science-computing.de>
	<15418.63966.866222.749974@charged.uio.no>
	<15420.23686.566719.128899@stderr.science-computing.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


     > Strange situation: both, you and the amd-guys, think the bug is
     > somewhere in the code of the other.

Although I won't exclude the fact that there may be a kernel bug, as
long as this condition is not reproducible with anything other than
amd, I'm going to need a lot of convincing.

     > And I have no idea, how to circle in the
     > bug.... (Kernel-debugging???)

That depends a lot on what it is amd actually does. Is it for instance
acting as a proxy between the client and the server, or in any other
way touching those packets?
I've never used amd, so I frankly have no idea what sort of special
thing it does on top of the standard NFS client. That's why I'd prefer
that Ion look into it.

If it turns out that a proper bugreport can be compiled that points to
a kernel NFS client problem, I'll be happy to help fix it. As things
stand, however, I am unable to reproduce any such problems on my own
setups and I have no spare time at the moment to start messing with
amd myself.

Cheers,
  Trond
