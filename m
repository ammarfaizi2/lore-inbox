Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272295AbRIKG0B>; Tue, 11 Sep 2001 02:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272298AbRIKGZv>; Tue, 11 Sep 2001 02:25:51 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:48396 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S272295AbRIKGZi>;
	Tue, 11 Sep 2001 02:25:38 -0400
Date: Mon, 10 Sep 2001 21:53:06 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Andreas Dilger <adilger@turbolabs.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <Pine.LNX.4.33.0109101611450.1034-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0109102151581.30234-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2001, Linus Torvalds wrote:
> > On September 11, 2001 12:39 am, Rik van Riel wrote:

> > > This suggests we may want to do agressive readahead on the
> > > inode blocks.

> So it' snot just about preloading. It's also about knowing about access
> patterns beforehand - something that the kernel really cannot do.
>
> Pre-loading your cache always depends on some limited portion of
> prescience.

OTOH, agressively pre-loading metadata should be ok in a lot
of cases, because metadata is very small, but wastes about
half of our disk time because of the seeks ...

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

