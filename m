Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135841AbREIXgO>; Wed, 9 May 2001 19:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135854AbREIXgF>; Wed, 9 May 2001 19:36:05 -0400
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:24583 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S135841AbREIXfv>; Wed, 9 May 2001 19:35:51 -0400
Date: Thu, 10 May 2001 00:35:45 +0100 (BST)
From: Chris Evans <chris@scary.beasts.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Andrew M. Theurer" <atheurer@austin.ibm.com>,
        Mike Kravetz <mkravetz@sequent.com>, <lse-tech@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@samba.org>
Subject: Re: Linux 2.4 Scalability, Samba, and Netbench
In-Reply-To: <E14xXvT-0002ri-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0105100033510.23676-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 May 2001, Alan Cox wrote:

> > significant problems with lockmeter.  csum_partial_copy_generic was the
> > highest % in profile, at 4.34%.  I'll see if we can get some space on
>
> Are you using Antons optimisations to samba to use sendfile ?

And you might like to try 2.4.4 (I saw 2.4.0 and 2.4.3 mentioned). 2.4.4
has the zerocopy TCP stuff (or was it 2.4.3 :)

Also, if the load is not disk limited, you might like to try Mingo's
pagecache/timers scalability patches. etc.

Cheers
Chris

