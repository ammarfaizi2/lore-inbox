Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130127AbRCBAVo>; Thu, 1 Mar 2001 19:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130141AbRCBAVf>; Thu, 1 Mar 2001 19:21:35 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:34571 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S130127AbRCBAVZ>;
	Thu, 1 Mar 2001 19:21:25 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200103020021.f220L3w224082@saturn.cs.uml.edu>
Subject: Re: [PATCH] Re: fat problem in 2.4.2
To: viro@math.psu.edu (Alexander Viro)
Date: Thu, 1 Mar 2001 19:21:03 -0500 (EST)
Cc: gator@cs.tu-berlin.de (Peter Daum), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0103010944001.11577-100000@weyl.math.psu.edu> from "Alexander Viro" at Mar 01, 2001 10:09:53 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:

[about file expansion by truncate]

> Basically, the program depends on behaviour that was never guaranteed
> to be there.

1. it is useful
2. it is documented in a few places AFAIK
3. it is portable enough for Star Office (Solaris I guess)

> BTW, _some_ subset is doable on FAT. You can't always do it (bloody
> thing doesn't support holes), but you can try the following (warning -
> untested patch):

Holes are nothing special. They are just a simple type of compression.
We are doing overcommit on filesystems, and need an OOD killer to
wipe out big files like the Star Office executable.
