Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263608AbRFTEBq>; Wed, 20 Jun 2001 00:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264196AbRFTEB1>; Wed, 20 Jun 2001 00:01:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9347 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263608AbRFTEBY>;
	Wed, 20 Jun 2001 00:01:24 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15152.8210.77166.139923@pizda.ninka.net>
Date: Tue, 19 Jun 2001 21:01:22 -0700 (PDT)
To: "Zack Weinberg" <zackw@Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, tridge@samba.org
Subject: Re: 2.2 PATCH: check return from copy_*_user in fs/pipe.c
In-Reply-To: <20010619205924.H5679@stanford.edu>
In-Reply-To: <15152.4073.812901.656882@pizda.ninka.net>
	<20010619205924.H5679@stanford.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zack Weinberg writes:
 > I don't think it's a security hole, if that's what you mean.

Right, because the kernel clears the post-fault bytes in the kernel
buffer.

Later,
David S. Miller
davem@redhat.com
