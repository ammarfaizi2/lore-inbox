Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132135AbRA3CM7>; Mon, 29 Jan 2001 21:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132158AbRA3CMs>; Mon, 29 Jan 2001 21:12:48 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:55734 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S132135AbRA3CMa>;
	Mon, 29 Jan 2001 21:12:30 -0500
Date: Mon, 29 Jan 2001 21:11:01 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Pavel Machek <pavel@suse.cz>
cc: Chris Wedgwood <cw@f00f.org>, <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: ECN: Clearing the air
In-Reply-To: <20010128225530.A1300@bug.ucw.cz>
Message-ID: <Pine.GSO.4.30.0101292108220.29307-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jan 2001, Pavel Machek wrote:

>
> Does not that mean that Linux 2.0.10 mistakenly announces it is ECN
> capable when offered ECN connection?

In fact it does. But as someone mentioned, ECN is resilient to this.
i.e this will be trapped and no ECN connection will happen.
For historical purposes, let it be noted that it was the Linux
ECN implementation in the 2.0 days that made this change in the RFC
possible. "we believe in running code ..." -- yes, indeed.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
