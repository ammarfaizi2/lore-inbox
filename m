Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135803AbRDYKnN>; Wed, 25 Apr 2001 06:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135809AbRDYKnD>; Wed, 25 Apr 2001 06:43:03 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:46084 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S135803AbRDYKmy>;
	Wed, 25 Apr 2001 06:42:54 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104251042.f3PAges164769@saturn.cs.uml.edu>
Subject: Re: [PATCH] Single user linux
To: imel96@trustix.co.id
Date: Wed, 25 Apr 2001 06:42:40 -0400 (EDT)
Cc: root@chaos.analogic.com (Richard B. Johnson),
        viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0104242029140.16230-100000@tessy.trustix.co.id> from "imel96@trustix.co.id" at Apr 24, 2001 08:37:51 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

imel96@trustix.co. writes:

> i didn't change all uid/gid to 0!
> 
> why? so with that radical patch, users will still have
> uid/gid so programs know the user's profile.

So you:

1. broke security (OK, fine...)
2. didn't remove all the support for security

It would be far more interesting to rip out all trace of security.
That would include the kernel memory access checking, parts of the
task struct, filesystem and VFS code, and surely much more.

Then you can try to show a measurable performance difference.
