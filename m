Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290598AbSAYIBl>; Fri, 25 Jan 2002 03:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290602AbSAYIB2>; Fri, 25 Jan 2002 03:01:28 -0500
Received: from mx2.elte.hu ([157.181.151.9]:44677 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290598AbSAYIBR>;
	Fri, 25 Jan 2002 03:01:17 -0500
Date: Fri, 25 Jan 2002 10:58:44 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <jfv@Bluesong.NET>
Cc: jfv <jfv@us.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>,
        jstultz <jstultz@us.ibm.com>
Subject: Re: [PATCH]: O(1) 2.4.17-J6 tuneable parameters
In-Reply-To: <200201250518.g0P5IrR13332@Bluesong.NET>
Message-ID: <Pine.LNX.4.33.0201251056250.3988-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Jan 2002, Jack F. Vogel wrote:

> 	Have been watching and testing your changes as they have
> evolved. Our group has a customer request for a scheduler that will
> give them some tuneable parameters, and your changes have actually had
> some parameters change thru the deltas you've made. It seemed like it
> might be useful to take them and make them tweakable on a running
> system. I am not 100% convinced of the goodness of this, but I wanted
> to submit it for your consideration.  The current code performs great
> btw, thanks for all your hard work.

i'm using something like this, hence the structured extraction of all
relevant parameters in -J6. It's very useful for testing. We do not want
to slow down the scheduler with runtime parameters though (and it's just
way too easy to change fundamental behavior of the scheduler by changing
the paramters), so this should definitely remain a development-helper
patch.

	Ingo

