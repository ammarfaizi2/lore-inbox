Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130147AbQLJJgl>; Sun, 10 Dec 2000 04:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130322AbQLJJgb>; Sun, 10 Dec 2000 04:36:31 -0500
Received: from vega.services.brown.edu ([128.148.19.202]:31904 "EHLO
	vega.brown.edu") by vger.kernel.org with ESMTP id <S130147AbQLJJgM>;
	Sun, 10 Dec 2000 04:36:12 -0500
Message-Id: <4.3.2.7.2.20001210040635.00b63340@postoffice.brown.edu>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sun, 10 Dec 2000 04:10:15 -0500
To: linux-kernel@vger.kernel.org
From: David Feuer <David_Feuer@brown.edu>
Subject: Re: swapoff weird
In-Reply-To: <20001210015623.V6567@cadcamlab.org>
In-Reply-To: <4.3.2.7.2.20001209174435.00aaf310@postoffice.brown.edu>
 <20001209222427.A1542@bug.ucw.cz>
 <4.3.2.7.2.20001209174435.00aaf310@postoffice.brown.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:56 AM 12/10/2000 -0600, Peter Samuelson wrote:

>[David Feuer]
> > Perhaps it would be good to put a check in unlink to make sure that
> > this is not the last link to a swapfile.
>
>Much better to add code to /sbin/swapon and /sbin/swapoff to set and
>clear immutable bit.  Sure it only works on ext2 but how far do you
>want to take this thing?

In a private email, linux@horizon.com  wrote:

>No; we should add some more magic-symlink /proc entries, like
>/proc/<pid>/fd/<n> for swap files.  Then they can be accessed
>by swapoff even if they're deleted.

Seems like a good idea to me...

--
This message has been brought to you by the letter alpha and the number pi.
Open Source: Think locally; act globally.
David Feuer
David_Feuer@brown.edu

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
