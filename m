Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289250AbSBDW7V>; Mon, 4 Feb 2002 17:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289255AbSBDW7M>; Mon, 4 Feb 2002 17:59:12 -0500
Received: from ua0d5hel.dial.kolumbus.fi ([62.248.132.0]:64011 "EHLO
	porkkala.uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S289250AbSBDW7C>; Mon, 4 Feb 2002 17:59:02 -0500
Message-ID: <3C5F1191.D90D7556@kolumbus.fi>
Date: Tue, 05 Feb 2002 00:56:17 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Ed Tomlinson <tomlins@cam.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <Pine.LNX.4.33.0202042303240.16086-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> please give it a test then (i'd suggest using the latest, -K2 patch) and
> let me know about what you find - this way we can fix any possible real
> problems instead of talking in hypotheticals.

I've been testing all your scheduler versions since first one.

Ok, now I made comparison test with exactly same kernel except other one
with -K2 patch. O1-K2 behaves significantly worse than old scheduler. I
think this behaviour was introduced somewhere around beginning of -J series.
I can't make kernel with old scheduler loose datablocks, but with O1 it
looses large percentage of the blocks.


	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

