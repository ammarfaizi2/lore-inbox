Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283267AbRLMDtV>; Wed, 12 Dec 2001 22:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283266AbRLMDtL>; Wed, 12 Dec 2001 22:49:11 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11401 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S283265AbRLMDs7>;
	Wed, 12 Dec 2001 22:48:59 -0500
Date: Wed, 12 Dec 2001 19:48:42 -0800 (PST)
Message-Id: <20011212.194842.66059225.davem@redhat.com>
To: znmeb@aracnet.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: __devexit_p() in linux-2.5.1-preX?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112121936180.22588-100000@shell1.aracnet.com>
In-Reply-To: <20011212.192636.133010681.davem@redhat.com>
	<Pine.LNX.4.33.0112121936180.22588-100000@shell1.aracnet.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
   Date: Wed, 12 Dec 2001 19:39:03 -0800 (PST)

   On Wed, 12 Dec 2001, David S. Miller wrote:
   
   > This brings up a more generic issue.  It would really be nice to have
   > someone who syncs up 2.5.X with the bug fixes going into the 2.4.x
   > series.  It really is needed, and it really is a boring and thankless
   > job :-)
   
   And the reason said boring thankless job can't be done by an automated
   revision control system is??

Because it requires a human brain to deal with the conflicts.
Any fixes to the block layer is going to have this problem,
and once we go to kbuild 2.5 these kinds of conflicts will
be even larger.

I use a revision control system, and have done so for 6 or more years,
and I have to merge a lot of things by hand.  It's not because I'm and
idiot, or that my revision control system sucks, it's simply because
interfaces and config/makefile format changes require by hand work.

