Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264484AbRFTCQs>; Tue, 19 Jun 2001 22:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264489AbRFTCQj>; Tue, 19 Jun 2001 22:16:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21378 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264484AbRFTCQ1>;
	Tue, 19 Jun 2001 22:16:27 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15152.1911.886630.381952@pizda.ninka.net>
Date: Tue, 19 Jun 2001 19:16:23 -0700 (PDT)
To: "Zack Weinberg" <zackw@stanford.edu>
Cc: linux-kernel@vger.kernel.org, tridge@samba.org
Subject: Re: 2.2 PATCH: check return from copy_*_user in fs/pipe.c
In-Reply-To: <20010619184802.D5679@stanford.edu>
In-Reply-To: <20010619184802.D5679@stanford.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zack Weinberg writes:
 > The anonymous pipe code in 2.2 does not check the return value of
 > copy_*_user.  This can lead to silent loss of data.

I remember Andrew Tridgell (cc:'d) spotting this a long time
ago, and we didn't fix it, and I forget what the reason was.

Andrew?

Later,
David S. Miller
davem@redhat.com
