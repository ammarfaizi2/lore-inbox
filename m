Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135588AbRAGEBZ>; Sat, 6 Jan 2001 23:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135599AbRAGEBP>; Sat, 6 Jan 2001 23:01:15 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:27812 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S135588AbRAGEBK>;
	Sat, 6 Jan 2001 23:01:10 -0500
Date: Sat, 6 Jan 2001 23:00:10 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Andi Kleen <ak@suse.de>
cc: Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
 policy!)
In-Reply-To: <20010107042959.A14330@gruyere.muc.suse.de>
Message-ID: <Pine.GSO.4.30.0101062253440.18916-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, Andi Kleen wrote:

> Does it make any significant different with the ifconfig from newest nettools? I
> removed a quadratic algorithm from ifconfig's device parsing, and with that I was
> able to display a few thousand alias devices on a unpatched kernel in reasonable time.

I think someone should just flush ifconfig down some toilet. a wrapper
around "ip" to to give the same look and feel as ifconfig would be a good
thing so that some stupid program that depends on ifconfig look and feel
would be a good start.

Not to stray from the subject, Ben's effort is still needed. I think real
numbers are useful instead of claims like it "displayed faster"

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
