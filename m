Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264493AbRFTCs5>; Tue, 19 Jun 2001 22:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264491AbRFTCsh>; Tue, 19 Jun 2001 22:48:37 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:21948 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S264490AbRFTCsa>; Tue, 19 Jun 2001 22:48:30 -0400
Date: Tue, 19 Jun 2001 19:48:27 -0700
From: "Zack Weinberg" <zackw@Stanford.EDU>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, tridge@samba.org
Subject: Re: 2.2 PATCH: check return from copy_*_user in fs/pipe.c
Message-ID: <20010619194827.F5679@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15152.1911.886630.381952@pizda.ninka.net>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 07:16:23PM -0700, David S. Miller wrote:
> 
> Zack Weinberg writes:
>  > The anonymous pipe code in 2.2 does not check the return value of
>  > copy_*_user.  This can lead to silent loss of data.
> 
> I remember Andrew Tridgell (cc:'d) spotting this a long time
> ago, and we didn't fix it, and I forget what the reason was.

It *has* been fixed in 2.4, though.  Some sort of compatibility issue?

-- 
zw                       This APT has Super Cow Powers.
                         	-- apt-get 0.5
