Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbQLGPzW>; Thu, 7 Dec 2000 10:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129535AbQLGPzM>; Thu, 7 Dec 2000 10:55:12 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:7298 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129415AbQLGPzB>;
	Thu, 7 Dec 2000 10:55:01 -0500
Date: Thu, 7 Dec 2000 10:24:31 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tigran Aivazian <tigran@veritas.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Andries Brouwer <aeb@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: [patch-2.4.0-test12-pre6] truncate(2) permissions
In-Reply-To: <Pine.LNX.4.21.0012071500110.970-100000@penguin.homenet>
Message-ID: <Pine.GSO.4.21.0012071008350.20144-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Dec 2000, Tigran Aivazian wrote:

> yet. So far you only said that a different implementation, i.e. a
> different place to put the checks, is preferrable.

-EPERM returned by permission() if we ask for write access to immutable.

Al, currently walking through the /usr/share/man/man2 and swearing silently...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
