Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275582AbRIZUYm>; Wed, 26 Sep 2001 16:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275579AbRIZUYc>; Wed, 26 Sep 2001 16:24:32 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:6152 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S275584AbRIZUYZ>;
	Wed, 26 Sep 2001 16:24:25 -0400
Date: Wed, 26 Sep 2001 22:24:50 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, bcrl@redhat.com,
        marcelo@conectiva.com.br, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
Message-ID: <20010926222450.A2196@suse.cz>
In-Reply-To: <Pine.LNX.4.33.0109261003480.8327-200000@penguin.transmeta.com> <E15mIfQ-0001E5-00@the-village.bc.nu> <20010926222021.A2086@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010926222021.A2086@suse.cz>; from vojtech@suse.cz on Wed, Sep 26, 2001 at 10:20:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 10:20:21PM +0200, Vojtech Pavlik wrote:

> > generic Athlon is
> > 
> > nothing: 11 cycles
> > locked add: 11 cycles
> > cpuid: 64 cycles
> 
> Interestingly enough, my TBird 1.1G insist on cpuid being somewhat
> slower:
> 
> nothing: 11 cycles
> locked add: 11 cycles
> cpuid: 87 cycles

Oops, this is indeed just a difference in compiler options.

-- 
Vojtech Pavlik
SuSE Labs
