Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287420AbRL3ODF>; Sun, 30 Dec 2001 09:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287421AbRL3OCz>; Sun, 30 Dec 2001 09:02:55 -0500
Received: from ns.suse.de ([213.95.15.193]:65028 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287420AbRL3OCs>;
	Sun, 30 Dec 2001 09:02:48 -0500
Date: Sun, 30 Dec 2001 15:02:47 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Manfred Spraul <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>,
        <torvalds@transmeta.com>
Subject: Re: [PATCH, COMPILE-FIX, TYPO] drivers/char/pc110pad.c
In-Reply-To: <E16KgQL-0001G3-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0112301456540.7143-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2001, Alan Cox wrote:

> > The bug was introduced between 2.4.17 and 2.5.1: someone added
> > spinlocks instead of cli(), without adding his name to the changelog.
> It was broken as part of the weird cli -> spinlock patch that someone added.
> I'd fixed it but there is no SMP PC110 so I never tested that case.

So someone improved SMP scalability on a driver only
used on hardware which can't do SMP ?

*boggle*

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

