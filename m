Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129253AbRBKVIt>; Sun, 11 Feb 2001 16:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130399AbRBKVIj>; Sun, 11 Feb 2001 16:08:39 -0500
Received: from ns.suse.de ([213.95.15.193]:17680 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129253AbRBKVI0>;
	Sun, 11 Feb 2001 16:08:26 -0500
Date: Sun, 11 Feb 2001 22:08:08 +0100
From: Andi Kleen <ak@suse.de>
To: Chris Evans <chris@scary.beasts.org>
Cc: Andi Kleen <ak@suse.de>, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: SO_LINGER + shutdown() does not block?
Message-ID: <20010211220808.A11649@gruyere.muc.suse.de>
In-Reply-To: <20010211215133.A11396@gruyere.muc.suse.de> <Pine.LNX.4.30.0102112103530.25011-100000@ferret.lmh.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0102112103530.25011-100000@ferret.lmh.ox.ac.uk>; from chris@scary.beasts.org on Sun, Feb 11, 2001 at 09:05:07PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2001 at 09:05:07PM +0000, Chris Evans wrote:
> 
> On Sun, 11 Feb 2001, Andi Kleen wrote:
> 
> > On Sun, Feb 11, 2001 at 08:41:04PM +0000, Chris Evans wrote:
> > >
> > > [cc: Andi]
> >
> > Missing context..
> 
> [...]
> 
> > What do you exactly think is wrong?
> 
> man socket(7) says that setting SO_LINGER on a socket will make shutdown()
> and close() block. That's incorrect; only close() blocks.

Ok, fixed. Thanks.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
