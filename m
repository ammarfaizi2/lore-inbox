Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315792AbSFJTFB>; Mon, 10 Jun 2002 15:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315785AbSFJTFB>; Mon, 10 Jun 2002 15:05:01 -0400
Received: from firewall.embl-grenoble.fr ([193.49.43.1]:65447 "HELO
	out.esrf.fr") by vger.kernel.org with SMTP id <S315792AbSFJTE7>;
	Mon, 10 Jun 2002 15:04:59 -0400
Date: Mon, 10 Jun 2002 21:03:58 +0200
From: Samuel Maftoul <maftoul@esrf.fr>
To: Hank Leininger <hlein@progressive-comp.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: /usr/bin/df reports false size on big NFS shares
Message-ID: <20020610210358.A16994@pcmaftoul.esrf.fr>
In-Reply-To: <200206101839.g5AIdDo29997@marc2.theaimsgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 02:39:13PM -0400, Hank Leininger wrote:
> Most distributions ship slightly (or heavily) patched kernels.  Above you
> can see the 2.4.4 kernel is not stock, it is named '2.4.4-4GB' for one
> thing, which most likely means it is tweaked for a 4GB memory system?  That
> may be how SuSE shipped kernels for 7.2, idunno.  But the point is, it is
> likely that stock 2.4.4 would not work either, it would have the same
> problem as 2.4.18.  There's some added bits in  SuSE's release kernel that
> make >1TB NFS shares happy.  I'd suggest that you try booting 2.4.4 stock
I'm using 2.4.18 unofficial srpm from suse ftp server, we need this
because we have hudge needs ( scientific research institute).
I think mostly the same patche are applied.
I'll try to find a "pirate" RH system (we don't support it) at work and
see if the same behavious applies.
> just to see if it misbehaves the same way 2.4.18 does, and if so, start
> trying to figure out what SuSE patch fixes this for you (check SuSE
> specific lists, and/or ask their support).  With luck you will find that
> either SuSE has a newer 2.4.x kernel with firewire support, or whatever
That's the point, their unofficial rpm's has it.
> they've done that fixes NFS can be extracted out and added to a current
> stock 2.4.x kernel source.
That probably won't be the case. :)
> --
> Hank Leininger <hlein@progressive-comp.com> 
        Sam
