Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280785AbRKLNo0>; Mon, 12 Nov 2001 08:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280776AbRKLNoQ>; Mon, 12 Nov 2001 08:44:16 -0500
Received: from smtp01.web.de ([194.45.170.210]:14354 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S280738AbRKLNn7> convert rfc822-to-8bit;
	Mon, 12 Nov 2001 08:43:59 -0500
Date: Mon, 12 Nov 2001 14:43:41 +0100 (CET)
From: Pascal Schmidt <pleasure.and.pain@web.de>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <20011111204305.A16792@unthought.net>
Message-ID: <Pine.LNX.4.33.0111121441030.1184-100000@neptune.sol.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2001, Jakob Østergaard wrote:

> Now, my program needs to deal with the data, perform operations on it,
> so naturally I need to know what kind of data I'm dealing with.  Most likely,
> my software will *expect* some certain type, but if I have no way of verifying
> that my assumption is correct, I will lose sooner or later...

Why not read everything into a 1024-bit signed variable? Will work for 
every numeric value in /proc. It's a bit of a hassle to code, but it is 
possible. You only need to know the type if you want to write a numerical 
value to a file in /proc, and even then the driver behind that /proc entry 
should do sanity checks.

-- 
Ciao, Pascal

-<[ pharao90@tzi.de, netmail 2:241/215.72, home http://cobol.cjb.net/) ]>-

