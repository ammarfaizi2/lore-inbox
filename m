Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132153AbRAYQ53>; Thu, 25 Jan 2001 11:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132382AbRAYQ5U>; Thu, 25 Jan 2001 11:57:20 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:59978 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S132153AbRAYQ5E>; Thu, 25 Jan 2001 11:57:04 -0500
Message-ID: <3A705B60.B9BF6A3F@ngforever.de>
Date: Thu, 25 Jan 2001 09:59:12 -0700
From: Thunder from the hill <thunder@ngforever.de>
X-Mailer: Mozilla 4.76 [en]C-CCK-MCD QXW03240  (WinNT; U)
X-Accept-Language: de,en-US
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Driver migration question
In-Reply-To: <14958.64899.320875.11952@somanetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The way drivers have to be done is mixed of two aspects:
1. The way you do drivers and
2. the way the driver works.
You should also try not to rewrite existing functions for not to get a
mess of e.g. memory allocation functions that do the same but have
different names.
Georg Nikodym wrote:
> 
> So, rather than repeated ask questions of the form:
> 
>         How do I change X (a 2.2 thingy in my driver) to the blessed
>         form on 2.4.x?
> 
> I'm wondering if there's a driver in the kernel tree that somebody can
> point to and say, "This is how drivers should be done."  In
> particular, I'm interested in networking drivers but any non-trivial
> driver will do.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
