Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269584AbRHQEMw>; Fri, 17 Aug 2001 00:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269589AbRHQEMm>; Fri, 17 Aug 2001 00:12:42 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:31495 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id <S269584AbRHQEMg>;
	Fri, 17 Aug 2001 00:12:36 -0400
Message-ID: <3B7C969D.4DFC6A5C@linux-m68k.org>
Date: Fri, 17 Aug 2001 05:59:25 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: aia21@cam.ac.uk, tpepper@vato.org, f5ibh@db0bm.ampr.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
In-Reply-To: <3B7C871E.1B37CA85@linux-m68k.org>
		<20010816.195906.38712979.davem@redhat.com>
		<3B7C8E15.3A0D9349@linux-m68k.org> <20010816.203732.107941169.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"David S. Miller" wrote:

>    Please show me a place in the kernel where such code is used and is
>    not dumb.
> 
> Why don't you point out an example yourself?  You seem pretty
> confident that a comparsion between a signed and unsigned value cannot
> possible be legitimate.

No, I did not say this. I said that such warning would be useful and
that the majority of users does not need the forced cast. This forced
cast is IMO more dangerous than useful.
I'd prefer people think about the warning, than suppress that warning
and let people run into subtle bugs. For the majority of uses, this will
be a bug or at least carelessness. For the minority of legal uses add a
cast + comment and everything is fine.

bye, Roman
