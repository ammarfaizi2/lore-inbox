Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290307AbSAPAo1>; Tue, 15 Jan 2002 19:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290308AbSAPAoT>; Tue, 15 Jan 2002 19:44:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57605 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290303AbSAPAoH>; Tue, 15 Jan 2002 19:44:07 -0500
Date: Tue, 15 Jan 2002 16:43:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Benjamin LaHaise <bcrl@redhat.com>, John Weber <weber@nyc.rr.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
In-Reply-To: <Pine.LNX.4.40.0201151644530.960-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0201151641260.1213-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Jan 2002, Davide Libenzi wrote:
>
> after that it builds for me ... but it crashes at boot time

Where?

The main big thing in 2.5.3-pre1 is the IDE driver update, the rest looks
fairly simple. I've tested the new IDE driver on my system (the famous
"Works For Me" test), and it's been tested quite a lot in earlier
incarnations on other platforms, but there might easily be some BIO or
low-level IDE chipset interactions.

If it's not in the IDE driver, I'm at a loss.

		Linus

