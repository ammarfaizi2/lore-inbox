Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269549AbRHQDgV>; Thu, 16 Aug 2001 23:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269580AbRHQDgN>; Thu, 16 Aug 2001 23:36:13 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:26375 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id <S269568AbRHQDgG>;
	Thu, 16 Aug 2001 23:36:06 -0400
Message-ID: <3B7C8E15.3A0D9349@linux-m68k.org>
Date: Fri, 17 Aug 2001 05:23:01 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: aia21@cam.ac.uk, tpepper@vato.org, f5ibh@db0bm.ampr.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
In-Reply-To: <3B7C8196.10D1C867@linux-m68k.org>
		<20010816.193841.98557608.davem@redhat.com>
		<3B7C871E.1B37CA85@linux-m68k.org> <20010816.195906.38712979.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"David S. Miller" wrote:

> Wrong.  This is legal:
> 
> int test(unsigned long a, int b)
> {
>         return min(a, b);
> }
> 
> And the compiler will warn about it with your typeof version.
> That is dumb and unacceptable.

Please show me a place in the kernel where such code is used and is not
dumb.

Could you please answer my argument about maintainability?

bye, Roman
