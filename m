Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269782AbRHKAtw>; Fri, 10 Aug 2001 20:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269787AbRHKAtm>; Fri, 10 Aug 2001 20:49:42 -0400
Received: from t2.redhat.com ([199.183.24.243]:18416 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S269782AbRHKAtd>; Fri, 10 Aug 2001 20:49:33 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.GSO.4.31.0107241528560.20515-100000@myth8.Stanford.EDU> 
In-Reply-To: <Pine.GSO.4.31.0107241528560.20515-100000@myth8.Stanford.EDU> 
To: Evan Parker <nave@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] null-deref errors for 2.4.7 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 Aug 2001 01:49:32 +0100
Message-ID: <17667.997490972@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


nave@stanford.edu said:
> [BUG] [GEM] highly suspicious: why kmalloc to *curmtd, then check if
> curmtd is NULL?  The check should probably be (!*curmtd) instead of
> (!curmtd).

You're correct. This is already fixed in my tree. My other pending patches 
haven't appeared in 2.4.8pre - must be time for a resend. I'll include the 
patch for this.

--
dwmw2


