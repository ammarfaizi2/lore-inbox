Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130329AbRAIMNV>; Tue, 9 Jan 2001 07:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbRAIMNB>; Tue, 9 Jan 2001 07:13:01 -0500
Received: from chiara.elte.hu ([157.181.150.200]:6412 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130329AbRAIMMv>;
	Tue, 9 Jan 2001 07:12:51 -0500
Date: Tue, 9 Jan 2001 13:12:28 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: <jes@linuxcare.com>, <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <200101082236.OAA22381@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0101091021170.1159-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Jan 2001, David S. Miller wrote:

>    All I am asking is that someone lets me know if they make major
>    changes to my code so I can keep track of whats happening.
>
> We have not made any major changes to your code, in lieu of this
> not being code which is actually being submitted yet.
>
> If it bothers you that publicly someone has published changes to your
> driver which you disagree with, oh well... :-)

i did tell Jes about our zerocopy work, months ago (and IIRC we even
exchanged emails about technical issues briefly). The changes were first
published in the TUX 1.0 source code last August, and subsequent cleanups
(more than 10 iterations) were published on Alexey's public FTP site:

	ftp://ftp.inr.ac.ru/ip-routing/

i think this whole issue got miscommunicated because Jes moved to Canada
exactly when we wrote the fragmented-API changes. I do believe Jes will
like most of our changes though, and i can surely tell that the elegant
and clean code of the Acenic driver made these changes so much easier.
Jen's Acenic driver was the first Linux networking driver in history to
support zero-copy TCP.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
