Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293632AbSDUEct>; Sun, 21 Apr 2002 00:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSDUEcs>; Sun, 21 Apr 2002 00:32:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24582 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293632AbSDUEcs>;
	Sun, 21 Apr 2002 00:32:48 -0400
Message-ID: <3CC240EB.AAD35A09@zip.com.au>
Date: Sat, 20 Apr 2002 21:32:43 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: viro@math.psu.edu, torvalds@transmeta.com, spyro@armlinux.org,
        linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
In-Reply-To: <Pine.GSO.4.21.0204202347010.27210-100000@weyl.math.psu.edu> <20020420.205958.123241031.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Alexander Viro <viro@math.psu.edu>
>    Date: Sun, 21 Apr 2002 00:05:27 -0400 (EDT)
> 
>    FWIW, I doubt that dropping -pre completely in favour of dayly snapshots is
>    a good idea - "2.5.N-preM oopses when ..." is preferable to "snapshot YY/MM/DD
>    oopses when..." simply because it's easier to match bug reports that way.
>    Having all deltas downloadable as diff+comment is wonderful, but it doesn't
>    replace well-defined (and less frequent) resync points.
> 
>    Comments?
> 
> I agree, make the daily's available but don't kill the -pre.

Dailies (nice) would need some distinguishing feature in EXTRAVERSION,
please.  "-20Apr02" would suit.  (I suspect if that started happening,
the -pre's would become redundant.  But that can be decided at a later
stage)

-
