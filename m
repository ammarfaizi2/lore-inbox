Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261809AbRESOUS>; Sat, 19 May 2001 10:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261823AbRESOUI>; Sat, 19 May 2001 10:20:08 -0400
Received: from hera.cwi.nl ([192.16.191.8]:33499 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261807AbRESOTz>;
	Sat, 19 May 2001 10:19:55 -0400
Date: Sat, 19 May 2001 16:19:19 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105191419.QAA53656.aeb@vlet.cwi.nl>
To: bcrl@redhat.com, viro@math.psu.edu
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH] device arguments from lookup)
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:

> Folks, before you get all excited about cramming side effects
> into open(2), consider ...

I agree completely.

> A lot of stuff relies on the fact that close(open(foo, O_RDONLY))
> is a no-op. Breaking that assumption is a Bad Thing(tm).

Also here I would like to agree. Unfortunately this is false.
Opening device files often has interesting side effects.

Andries
