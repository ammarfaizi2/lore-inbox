Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131894AbRAQUdT>; Wed, 17 Jan 2001 15:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132130AbRAQUdK>; Wed, 17 Jan 2001 15:33:10 -0500
Received: from comunit.de ([195.21.213.33]:26218 "HELO comunit.de")
	by vger.kernel.org with SMTP id <S131894AbRAQUcc>;
	Wed, 17 Jan 2001 15:32:32 -0500
Date: Wed, 17 Jan 2001 21:32:30 +0100 (CET)
From: Sven Koch <haegar@cut.de>
To: Shawn Starr <Shawn.Starr@Home.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTION]: Applying patches ontop of patches (2.4.1pre7 to
 2.4.1pre8)
In-Reply-To: <3A65F3DA.7E2C8823@Home.net>
Message-ID: <Pine.LNX.4.30.0101172130580.2313-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Shawn Starr wrote:

> What is the best way to apply a patch on top of a patch already applied?
>
> For example, with original sources 2.4.0 i applied 2.4.1pre7 but now
> that pre8 is out, how do i apply those new patches without having to
> delete the whole linux dir and untar 2.4.0 again just to apply pre8?

reverse the patch for 2.4.1pre7

for example: cd /usr/src/linux ; zcat 2.4.1pre7.gz | patch -p1 -R

after that apply pre8

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
