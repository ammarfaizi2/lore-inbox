Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129110AbQJaXpq>; Tue, 31 Oct 2000 18:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129168AbQJaXpg>; Tue, 31 Oct 2000 18:45:36 -0500
Received: from chiara.elte.hu ([157.181.150.200]:53767 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129110AbQJaXp0>;
	Tue, 31 Oct 2000 18:45:26 -0500
Date: Wed, 1 Nov 2000 01:55:23 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <Pine.LNX.3.95.1001031174047.165A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.21.0011010151000.18581-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 31 Oct 2000, Richard B. Johnson wrote:

> However, these techniques are not useful with a kernel that has an
> unknown number of tasks that execute 'programs' that are not known to
> the kernel at compile-time, such as a desk-top operating system.

yep, exactly. It simply optimizes the wrong thing and restricts
architectural flexibility. It is very easy to optimize by making
a system more specific. (this is fact is a more or less automatic
engineering work) The real optimizations are the ones that do not
take away from the generic nature of the system.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
