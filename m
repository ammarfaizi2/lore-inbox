Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131429AbQKJWSY>; Fri, 10 Nov 2000 17:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131515AbQKJWSP>; Fri, 10 Nov 2000 17:18:15 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:23995 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131429AbQKJWSJ>;
	Fri, 10 Nov 2000 17:18:09 -0500
Date: Fri, 10 Nov 2000 17:18:02 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: sendmail-bugs@Sendmail.ORG, linux-kernel@vger.kernel.org
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
In-Reply-To: <3A0C7139.DDD81E67@timpanogas.org>
Message-ID: <Pine.GSO.4.21.0011101712390.17943-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Nov 2000, Jeff V. Merkey wrote:

> 
> Then perhaps qmail's time has finally come .... If sendmail cannot run
> on a machine with minimal background loading from a dozen or so FTP
> clients downloading files, it's clearly sick.  BTW.  I have another box
> running qmail, and it doesn't have these problems.

If you have permanently high load average - sure, you need to bump
the limits. Always had been that way, nothing to do with the kernel.
OTOH, I really don't see WTF are FTP clients giving that kind of LA -
unless you've got really thick pipe on a box, that is. If it's a server -
WTF are they doing there at all? And if it isn't... Nice connectivity
you have there.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
