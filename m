Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319058AbSIDFNs>; Wed, 4 Sep 2002 01:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319057AbSIDFNo>; Wed, 4 Sep 2002 01:13:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49159 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319058AbSIDFNl>; Wed, 4 Sep 2002 01:13:41 -0400
Date: Tue, 3 Sep 2002 22:17:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: rusty@rustcorp.com.au, <linux-kernel@vger.kernel.org>, <akpm@zip.com.au>
Subject: Re: [PATCH] Important per-cpu fix. 
In-Reply-To: <20020903.220514.21399526.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0209032216570.1439-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Sep 2002, David S. Miller wrote:
> Oh, "I'm" willing to upgrade "my" compiler, it's my users
> that are the problem.  If you impose 3.1 or whatever, I get less
> people testing on sparc64 as a result.

Well, I don't think you have to go to 3.1.x.

gcc-2.96 at least seems to do all right. Apparently 2.95 does too. It's 
only the truly ancient compilers that don't work.

		Linus

