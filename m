Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284163AbRLRO6E>; Tue, 18 Dec 2001 09:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284195AbRLRO5y>; Tue, 18 Dec 2001 09:57:54 -0500
Received: from mx2.elte.hu ([157.181.151.9]:14481 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S284163AbRLRO5n>;
	Tue, 18 Dec 2001 09:57:43 -0500
Date: Tue, 18 Dec 2001 17:55:14 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Victor Yodaiken <yodaiken@fsmlabs.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mempool design
In-Reply-To: <20011217083802.A25219@hq2>
Message-ID: <Pine.LNX.4.33.0112181753230.3753-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Dec 2001, Victor Yodaiken wrote:

> I agree with all your arguments up to here. But being able to run
> Linux in 4Meg or even 8M is important to a very large class of
> applications. [...]

the amount of reserved RAM should be very low. Especially in embedded
applications that usually have a very controlled environment, with a low
number of well-behaving devices, the number of pages needed to be reserved
is very low. I wouldnt worry about this.

	Ingo

