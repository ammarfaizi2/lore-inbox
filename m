Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316227AbSEVQOo>; Wed, 22 May 2002 12:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316232AbSEVQNK>; Wed, 22 May 2002 12:13:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26128 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316227AbSEVQM0>; Wed, 22 May 2002 12:12:26 -0400
Date: Wed, 22 May 2002 09:10:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave McCracken <dmccr@us.ibm.com>
cc: "David S. Miller" <davem@redhat.com>, <zippel@linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <10810000.1022076893@baldur.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0205220909510.7580-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Dave McCracken wrote:
>
> What would be the incremental cost of just switching to init_mm?

Pretty much zero.

Switching to init_mm is the easy approach with no real downside, it just
has the downside that it's also guaranteed to have no upside (ie there is
no win on the _next_ context switch).

			Linus

