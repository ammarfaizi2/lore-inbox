Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129886AbRALWDD>; Fri, 12 Jan 2001 17:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129811AbRALWCx>; Fri, 12 Jan 2001 17:02:53 -0500
Received: from ns.stesmi.com ([212.209.57.62]:25672 "EHLO mckinley.stesmi.com")
	by vger.kernel.org with ESMTP id <S129538AbRALWCi>;
	Fri, 12 Jan 2001 17:02:38 -0500
Message-ID: <3A5F7F85.62054716@hanse.com>
Date: Fri, 12 Jan 2001 23:04:53 +0100
From: Stefan Smietanowski <stefan@hanse.com>
Organization: Hanse Communication
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Shawn Starr <Shawn.Starr@Home.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM]: Strange network problems with 2.4.0 and 3c59x.o
In-Reply-To: <Pine.LNX.4.10.10101020019010.8957-100000@vaio.greennet> <3A51D40F.48B9ADB9@home.net> <3A5F791F.BCC236C1@Home.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> Here's something strange that i've been noticing with 2.4.0. Some websites I am
> unable to access now. For example:

<snip about sites>

This is a FAQ. Check if you compiled with ECN enabled (CONFIG_INET_ECN).
Some sites have broken firewalls that drop packets of that type. Either
don't surf to those sites or disable ECN. This will all work when all
sites upgrade their firewalls *cough*.

// Stefan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
