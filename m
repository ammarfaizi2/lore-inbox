Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132127AbRAaBP0>; Tue, 30 Jan 2001 20:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132283AbRAaBPR>; Tue, 30 Jan 2001 20:15:17 -0500
Received: from chiara.elte.hu ([157.181.150.200]:50949 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132127AbRAaBPJ>;
	Tue, 30 Jan 2001 20:15:09 -0500
Date: Wed, 31 Jan 2001 02:14:35 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: jamal <hadi@cyberus.ca>
Cc: Ion Badulescu <ionut@cs.columbia.edu>, Andrew Morton <andrewm@uow.edu.au>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: Still not sexy! (Re: sendfile+zerocopy: fairly sexy (nothing to
 do with ECN)
In-Reply-To: <Pine.GSO.4.30.0101302000471.3017-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.30.0101310213400.13467-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Jan 2001, jamal wrote:

> > - is this UDP or TCP based? (UDP i guess)
> >
> TCP

well then i'd suggest to do:

	echo 100000 100000 100000 > /proc/sys/net/ipv4/tcp_wmem

does this make any difference?

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
