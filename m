Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272685AbRHaNp7>; Fri, 31 Aug 2001 09:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272688AbRHaNpu>; Fri, 31 Aug 2001 09:45:50 -0400
Received: from relay1.zonnet.nl ([62.58.50.37]:18124 "EHLO relay1.zonnet.nl")
	by vger.kernel.org with ESMTP id <S272685AbRHaNpo>;
	Fri, 31 Aug 2001 09:45:44 -0400
Message-ID: <3B8F9507.859D584F@linux-m68k.org>
Date: Fri, 31 Aug 2001 15:45:43 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Ion Badulescu <ionut@cs.columbia.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.4.33.0108300902570.7973-100000@penguin.transmeta.com> <Pine.LNX.4.33.0108301217280.9230-100000@age.cs.columbia.edu> <20010831135034.B25128@thefinal.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jamie Lokier wrote:

>    2. Warning added to GCC for casts which reduce argument range, but
>       only when explicitly requested by an attribute on the cast...

How many false positives will this produce? I think, Linus will hate
this warning even more than -Wsign-compare.

>    3. Warning added to GCC for signed vs. unsigned comparisons
>       _regardless_ of type size.  This would also catch erroneous
>       unsigned char vs. EOF checks in misuses of stdio.

Do you know of such bug in the context of min()?

bye, Roman
