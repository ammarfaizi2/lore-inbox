Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317797AbSFSHDY>; Wed, 19 Jun 2002 03:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317798AbSFSHDX>; Wed, 19 Jun 2002 03:03:23 -0400
Received: from hera.cwi.nl ([192.16.191.8]:4794 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S317797AbSFSHDW>;
	Wed, 19 Jun 2002 03:03:22 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 19 Jun 2002 09:02:50 +0200 (MEST)
Message-Id: <UTC200206190702.g5J72oj08454.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, torvalds@transmeta.com
Subject: Re: [PATCH+discussion] symlink recursion
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could we allow deeper recursion if we did it by hand? Sure.
> Are there any real advantages in 15 levels of recursion
> over 5 levels of recursion? I don't see any.

There is a real advantage in a max depth that is an arbitrary
parameter that anybody can pick suitably, above a max 5 that
one cannot increase without danger of kernel stack overflow.

Andries
