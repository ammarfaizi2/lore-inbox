Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276197AbRI1RlU>; Fri, 28 Sep 2001 13:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276202AbRI1RlK>; Fri, 28 Sep 2001 13:41:10 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:14602 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S276197AbRI1Rk5>;
	Fri, 28 Sep 2001 13:40:57 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200109281741.VAA04648@ms2.inr.ac.ru>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
To: riel@conectiva.com.br (Rik van Riel)
Date: Fri, 28 Sep 2001 21:41:00 +0400 (MSK DST)
Cc: mingo@elte.hu, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, bcrl@redhat.com, andrea@suse.de
In-Reply-To: <Pine.LNX.4.33L.0109281420180.26495-100000@duckman.distro.conectiva> from "Rik van Riel" at Sep 28, 1 02:21:07 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Then how would you explain the 10% speed difference
> Ben and others have seen with gigabit ethernet ?

Huh... kill all the softirqs (and, even better, scheduler too) and you will
see even more effect. :-)

More seriously, the question is not why these 10% appears,
but rather why they _disappeared_ in 2.4.7.

Alexey
