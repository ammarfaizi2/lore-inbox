Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132012AbQKJW1E>; Fri, 10 Nov 2000 17:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132000AbQKJW05>; Fri, 10 Nov 2000 17:26:57 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:19428 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S132012AbQKJW0k>; Fri, 10 Nov 2000 17:26:40 -0500
Date: Fri, 10 Nov 2000 17:23:53 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: <sendmail-bugs@Sendmail.ORG>, <linux-kernel@vger.kernel.org>
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
In-Reply-To: <3A0C7139.DDD81E67@timpanogas.org>
Message-ID: <Pine.LNX.4.30.0011101719440.19584-100000@back40.badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, Jeff V. Merkey wrote:

> Then perhaps qmail's time has finally come .... If sendmail cannot run
> on a machine with minimal background loading from a dozen or so FTP
> clients downloading files, it's clearly sick.  BTW.  I have another box
> running qmail, and it doesn't have these problems.

I have several boxen running sendmail with fair to moderate loading -
they even occasionally don't accept mail... and thats good, as it lets
the system catch up with its current load.  As soon as things stabalize,
sendmail again accepts connections - you *do* have MX entries don't you?

I've *never* had the problem you've got with *any* of the boxes - maybe
you should rethink your setup.  I'll wager that the qmail box isn't as
heavily loaded as the one running sendmail; why not split your services?
-- 
Rick Nelson
There are two types of Linux developers - those who can spell, and
those who can't. There is a constant pitched battle between the two.
(From one of the post-1.1.54 kernel update messages posted to c.o.l.a)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
