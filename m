Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274349AbRIVH2u>; Sat, 22 Sep 2001 03:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274321AbRIVH2k>; Sat, 22 Sep 2001 03:28:40 -0400
Received: from [195.223.140.107] ([195.223.140.107]:50418 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274349AbRIVH22>;
	Sat, 22 Sep 2001 03:28:28 -0400
Date: Sat, 22 Sep 2001 09:28:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre13aa1
Message-ID: <20010922092859.N11674@athlon.random>
In-Reply-To: <20010921095721.A725@athlon.random> <20010921131841.A15773@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010921131841.A15773@redhat.com>; from bcrl@redhat.com on Fri, Sep 21, 2001 at 01:18:41PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2001 at 01:18:41PM -0400, Benjamin LaHaise wrote:
> the page.  If people are truely paranoid, then make it a boot time assertion.

What do you think if I replace the mkdirty with a BUG() in case the pte
gets marked dirty? Just to be sure no hardware gets it wrong.

Andrea
