Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262911AbREWADB>; Tue, 22 May 2001 20:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262910AbREWACv>; Tue, 22 May 2001 20:02:51 -0400
Received: from hera.cwi.nl ([192.16.191.8]:29377 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262903AbREWACd>;
	Tue, 22 May 2001 20:02:33 -0400
Date: Wed, 23 May 2001 02:01:46 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105230001.CAA70296.aeb@vlet.cwi.nl>
To: torvalds@transmeta.com, viro@math.psu.edu
Subject: Re: [PATCH] struct char_device
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do we really want a separate queue for each partition?

No.

> I have a half-baked patch

Me too. (Not half-baked but brewed.) In principle the change
is trivial, but there are a few IDE issues that are presently
solved in a very low-level way (and incorrectly).
This makes the patch larger than expected at first sight.

Andries

