Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbQLGTnw>; Thu, 7 Dec 2000 14:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbQLGTnn>; Thu, 7 Dec 2000 14:43:43 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:1542 "EHLO
	smtp.lax.megapath.net") by vger.kernel.org with ESMTP
	id <S129595AbQLGTni>; Thu, 7 Dec 2000 14:43:38 -0500
Message-ID: <3A2FE0DA.5080100@megapathdsl.net>
Date: Thu, 07 Dec 2000 11:11:22 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 i686; en-US; m18) Gecko/20001206
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Russell King <rmk@arm.linux.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test12-pre7
In-Reply-To: <Pine.LNX.4.10.10012070923210.2370-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> probably vote for getting rid of the device enables in
> pci_assign_unassigned_resources() (for all the reasons already mentioned
> by others - scribbling over memory due to not being quiescent etc). But
> it's not worth breaking now. 2.5.x material. Most PCI drivers may already
> do the right thing, but I bet that the USB driver wasn't the only one who
> forgot..

Is anyone compiling these change lists for 2.5?  I seem to see a few
of these ideas mentioned on LKML each week.  It would be nice to not
have these ideas fade away.

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
