Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131489AbRAQUzC>; Wed, 17 Jan 2001 15:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132061AbRAQUyv>; Wed, 17 Jan 2001 15:54:51 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:2042 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S131489AbRAQUyh>; Wed, 17 Jan 2001 15:54:37 -0500
Date: Wed, 17 Jan 2001 12:54:27 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Dominik Kubla <dominik.kubla@uni-mainz.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: APIC errors
In-Reply-To: <20010117091432.B29123@uni-mainz.de>
Message-ID: <Pine.LNX.4.21.0101171250520.30136-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Dominik Kubla wrote:

> Just switched to 2.4.0-ac9 (+crypto patches) on our Dual-Pentium MMX
> webserver yesterday.  Works fine so far, except i keep seeing those
> APIC erros (about 14 in 12 hrs) indicating receive, send and CS errors.

Make sure your system is free of dust...dust can cause small errors like
this to occur. Also make sure that the temperature of the system is within
tolerable levels. Also, a capacitor on your motherboard could be
failing...there are many different things that could cause this error.

> Should i be concerned?

Probably not. The errors were there before yo upgraded the kernel; they
just weren't reported. Those messages are merely letting you know that an
APIC retry happened. The message still got to the controller; it just had
to get sent twice.

good luck,
-kelsey

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
