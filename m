Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272448AbRIKN0k>; Tue, 11 Sep 2001 09:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272418AbRIKN0a>; Tue, 11 Sep 2001 09:26:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2828 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268100AbRIKN0R>; Tue, 11 Sep 2001 09:26:17 -0400
Date: Tue, 11 Sep 2001 15:26:26 +0200
From: Jan Kara <jack@suse.cz>
To: Juan Pablo Abuyeres <jpabuyer@tecnoera.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac10 + reiserfs + quota
Message-ID: <20010911152626.V28691@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.33.0109101955150.6080-100000@baltazar.tecnoera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33.0109101955150.6080-100000@baltazar.tecnoera.com>; from jpabuyer@tecnoera.com on Mon, Sep 10, 2001 at 08:04:45PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> 	I just compiled 2.4.9-ac10 with reiserfs support. Now I need to
> set up quota, but watching
> http://www.namesys.com/pub/reiserfs-for-2.4/quota-for-3.6/ I realized
> there's no quota patch for this kernel version yet..... so what should I
> do??
  -ac kernels contain new quota code so you can use new reiserfs quota
support from ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/reiserfs.
Currently the best patch for you should be for 2.4.0-pre4 (something like
reiserquota-patch-2.4.0-pre4-3.diff.gz) I should make patch for 2.4.9-ac10
soon too. But there's one possible deadlock in the code Chris Mason is working
on (I think he's got to testing now :)) so maybe it'd be better to wait for
a few days for the patch without deadlocks...

								Honza

--
Jan Kara <jack@suse.cz>
SuSE Labs
