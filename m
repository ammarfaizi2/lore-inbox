Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282101AbRKWKIs>; Fri, 23 Nov 2001 05:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282106AbRKWKIi>; Fri, 23 Nov 2001 05:08:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:28618 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282101AbRKWKI2>;
	Fri, 23 Nov 2001 05:08:28 -0500
Date: Fri, 23 Nov 2001 13:06:15 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: J Sloan <jjs@pobox.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sunrpc woes with tux2 in 2.4.15-pre8,9
In-Reply-To: <3BFD7633.2525641E@pobox.com>
Message-ID: <Pine.LNX.4.33.0111231257070.5254-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


following Trond's suggestions i reverted the dec_and_lock hacks from the
TUX patch. Could you try the latest 2.4.15-B2 patch:

	http://redhat.com/~mingo/TUX-patches/tux2-full-2.4.15-pre9-B2.bz2

(it will apply to 2.4.15-final just as well) Does this solve the symbol
export problem?

	Ingo


