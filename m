Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276194AbRI1Rck>; Fri, 28 Sep 2001 13:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276191AbRI1Rca>; Fri, 28 Sep 2001 13:32:30 -0400
Received: from [195.223.140.107] ([195.223.140.107]:60405 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S276190AbRI1Rc0>;
	Fri, 28 Sep 2001 13:32:26 -0400
Date: Fri, 28 Sep 2001 19:31:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: kuznet@ms2.inr.ac.ru, mingo@elte.hu, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        bcrl@redhat.com
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
Message-ID: <20010928193147.R24922@athlon.random>
In-Reply-To: <200109281704.VAA04444@ms2.inr.ac.ru> <Pine.LNX.4.33L.0109281420180.26495-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109281420180.26495-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Fri, Sep 28, 2001 at 02:21:07PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 02:21:07PM -0300, Rik van Riel wrote:
> Then how would you explain the 10% speed difference
> Ben and others have seen with gigabit ethernet ?

partly because of the unwakeup logic, I've no problem with it, this is
why I asked to measure how much of the 10% improvement cames from the
unwakeup/ksoftirqd-deschedule logic, I was just curious about that.

Andrea
