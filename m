Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274688AbRIYW7J>; Tue, 25 Sep 2001 18:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274683AbRIYW6w>; Tue, 25 Sep 2001 18:58:52 -0400
Received: from [195.223.140.107] ([195.223.140.107]:47344 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274685AbRIYW6d>;
	Tue, 25 Sep 2001 18:58:33 -0400
Date: Wed, 26 Sep 2001 00:59:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: marcelo@conectiva.com.br, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
Message-ID: <20010926005903.T8350@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0109251539150.2193-100000@freak.distro.conectiva> <20010925.131528.78383994.davem@redhat.com> <20010926000102.G8350@athlon.random> <20010925.150328.75780096.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010925.150328.75780096.davem@redhat.com>; from davem@redhat.com on Tue, Sep 25, 2001 at 03:03:28PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 03:03:28PM -0700, David S. Miller wrote:
>    From: Andrea Arcangeli <andrea@suse.de>
>    Date: Wed, 26 Sep 2001 00:01:02 +0200
>    
>    IMHO if we would hold the pagecache lock all the time while shrinking
>    the cache, then we could kill the lru lock in first place.
> 
> And actually in the pagecache locking patches, doing such a thing
> would be impossible :-) since each page needs to grab a different

good further point too :), it would be an option only for mainline.

Andrea
