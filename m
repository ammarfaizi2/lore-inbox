Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130696AbRANJTD>; Sun, 14 Jan 2001 04:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131598AbRANJSy>; Sun, 14 Jan 2001 04:18:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8346 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130696AbRANJSh>;
	Sun, 14 Jan 2001 04:18:37 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14945.28354.209720.579437@pizda.ninka.net>
Date: Sun, 14 Jan 2001 01:17:54 -0800 (PST)
To: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
Cc: Harald Welte <laforge@gnumonks.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 + iproute2
In-Reply-To: <Pine.LNX.4.30.0101141013080.16469-100000@jdi.jdimedia.nl>
In-Reply-To: <14945.26991.35849.95234@pizda.ninka.net>
	<Pine.LNX.4.30.0101141013080.16469-100000@jdi.jdimedia.nl>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Igmar Palsenberg writes:

 > we might want to consider changing the error the call gives in case
 > MULTIPLE_TABLES isn't set. -EINVAL is ugly, -ENOSYS should make the error
 > more clear..

How do I tell the difference between using the wrong system call
number to invoke an ioctl or socket option change, and making a
call for a feature I haven't configured into my kernel?

I think ENOSYS is just a bad a choice.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
