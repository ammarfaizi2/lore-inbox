Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbRCATIV>; Thu, 1 Mar 2001 14:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129813AbRCATIM>; Thu, 1 Mar 2001 14:08:12 -0500
Received: from pizda.ninka.net ([216.101.162.242]:25479 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129811AbRCATH6>;
	Thu, 1 Mar 2001 14:07:58 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15006.40279.407072.321187@pizda.ninka.net>
Date: Thu, 1 Mar 2001 11:04:55 -0800 (PST)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        Ivan Stepnikov <iv@spylog.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel is unstable
In-Reply-To: <20010301193017.E15051@athlon.random>
In-Reply-To: <20010301153935.G32484@athlon.random>
	<E14YXh5-0008GQ-00@the-village.bc.nu>
	<20010301193017.E15051@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:
 > If it happened to be buggy it didn't looked unfixable from a design standpoint
 > and I think it was a very worthwhile feature, not just for memory but also to
 > avoid growing the size of the avl that we would have to pay later all the time
 > at each page fault.

Linus didn't find it to be such a gain, and in fact the one
place that does gain from such merging (sys_brk()) does the
merging by hand :-)

Later,
David S. Miller
davem@redhat.com
