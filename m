Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316399AbSEOPR1>; Wed, 15 May 2002 11:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316403AbSEOPR0>; Wed, 15 May 2002 11:17:26 -0400
Received: from [195.223.140.120] ([195.223.140.120]:29292 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316399AbSEOPRX>; Wed, 15 May 2002 11:17:23 -0400
Date: Wed, 15 May 2002 17:17:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, Andrey Nekrasov <andy@spylog.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: Adaptec Aic7xxx driver & 2.4.19pre8aa2
Message-ID: <20020515151717.GA20464@dualathlon.random>
In-Reply-To: <20020515164802.GG25593@dualathlon.random> <E1780jL-0002Ac-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 04:30:19PM +0100, Alan Cox wrote:
> > > >Hardware motherboard: Intel "Lancewood" L440GX, SCSI integrated, last BIOS/BMC
> 
> 440GX
> 
> > search across the 2.4.19pre patches (from pre2 to pre8) that would limit
> > the bug to a certain diff. thanks,
> 
> No need. The 440GX stuff is a known disaster area. You must use APIC support
> on those and Intel doesn't want to be helpful on non APIC stuff.

I was assuming he used the same .config (with IO-APIC enabled), if not
then that's the problem. Really such part of .config wasn't shown.

Andrea
