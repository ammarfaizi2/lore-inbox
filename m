Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbSLUMbR>; Sat, 21 Dec 2002 07:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbSLUMbR>; Sat, 21 Dec 2002 07:31:17 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:24706 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S266907AbSLUMbQ> convert rfc822-to-8bit; Sat, 21 Dec 2002 07:31:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] scheduler tunables with contest - interactive_delta
Date: Sat, 21 Dec 2002 23:40:50 +1100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>
References: <200212211539.56815.conman@kolivas.net> <200212211307.15666.m.c.p@wolk-project.de>
In-Reply-To: <200212211307.15666.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212212341.07504.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>On Saturday 21 December 2002 05:39, Con Kolivas wrote:
>
>Hi Con,
>
>> Seems like io_load likes lower interactive deltas (lower the better?) and
>> mem_load likes high interactive_deltas (sweet spot 5).
>
>Yes, seems so. I think this is a good thing for autoregulating 8-)

Exactly my thoughts. Increasingly as the numbers are rolling out it is clear 
the defaults seem to be pretty darn good (thanks mingo), but for -ck at least 
I wont be able to resist and will autoregulate them once I have a full set of 
numbers to play with. I'll get subsets of numbers (too messy to post them all 
here) and decide what to use for my ranges. It's my impression so far that 
the desktop experience with static numbers can only be improved upon by 
dropping the max timeslice to resemble that of the old scheduler. Perhaps a 
max timeslice of around 150ms.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+BGFVF6dfvkL3i1gRAkQBAJsH5MLDRvSpa2VIY+u4Up2FZhdkUQCgg8sq
FAQx+63jqkrR1IUHIA3zZVQ=
=jWrY
-----END PGP SIGNATURE-----
