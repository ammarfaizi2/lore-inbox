Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <153872-8316>; Thu, 10 Sep 1998 01:18:14 -0400
Received: from post-12.mail.demon.net ([194.217.242.41]:49869 "EHLO post.mail.demon.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154163-8316>; Thu, 10 Sep 1998 00:56:33 -0400
Message-ID: <19980910073422.A13283@tantalophile.demon.co.uk>
Date: Thu, 10 Sep 1998 07:34:22 +0100
From: Jamie Lokier <lkd@tantalophile.demon.co.uk>
To: linux-kernel@vger.rutgers.edu
Subject: Re: GPS Leap Second Scheduled!
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <no.id>; from David Lang on Wed, Sep 09, 1998 at 09:35:59AM -0700
Sender: owner-linux-kernel@vger.rutgers.edu

On Wed, Sep 09, 1998 at 09:35:59AM -0700, David Lang wrote:
> I am probably missing something, but can't you just ignore the leap second
> until you discover that the time is 1 sec off and then use the normal NTP
> procedure to get back to the exact time

Until the NTP procedure discovers and corrects this (a few minutes, plus
correction time), anything that expects synchronised time between
machines can go wrong.

Admittedly synchronisation isn't perfect anyway.

-- Jamie

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
