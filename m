Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267622AbRGNKww>; Sat, 14 Jul 2001 06:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267620AbRGNKwm>; Sat, 14 Jul 2001 06:52:42 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:22746 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S267612AbRGNKwc>; Sat, 14 Jul 2001 06:52:32 -0400
Message-ID: <3B5024C1.428EF863@uow.edu.au>
Date: Sat, 14 Jul 2001 20:53:53 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Black <mblack@csihq.com>
CC: "Stephen C. Tweedie" <sct@redhat.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: 2.4.6 and ext3-2.4-0.9.1-246
In-Reply-To: <02ae01c10925$4b791170$e1de11cc@csihq.com> <3B4BD13F.6CC25B6F@uow.edu.au> <021801c10a03$62434540$e1de11cc@csihq.com> <3B4C729B.6352A443@uow.edu.au> <05c401c10ac1$0e81ad70$e1de11cc@csihq.com> <3B4D8B5D.E9530B60@uow.edu.au> <036e01c10b96$72ce57d0$e1de11cc@csihq.com> <111501c10ba3$664a1370$e1de11cc@csihq.com> <3B4F0273.1DF40F8E@uow.edu.au> <125101c10bc1$85eab630$e1de11cc@csihq.com> <20010713183800.J13419@redhat.com> <001101c10c51$bd6239e0$b6562341@cfl.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Black wrote:
> 
> Only when I rebooted and fsck ran :-(
> 

What version of ext3 was it?

It's quite easy to reproduce the raid5/VM problems here - the
system slows to a crawl with the disk only using about 1/10th
of its bandwidth.  Much worse if highmem is enabled.

Does this match your observations?

-
