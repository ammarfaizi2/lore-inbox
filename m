Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268442AbRGXTle>; Tue, 24 Jul 2001 15:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268441AbRGXTlY>; Tue, 24 Jul 2001 15:41:24 -0400
Received: from smtp1.legato.com ([137.69.200.1]:30419 "EHLO smtp1.legato.com")
	by vger.kernel.org with ESMTP id <S268439AbRGXTlN>;
	Tue, 24 Jul 2001 15:41:13 -0400
Message-ID: <01dc01c11478$9a529920$5c044589@legato.com>
From: "David E. Weekly" <dweekly@legato.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0107241514160.20326-100000@duckman.distro.conectiva>
Subject: Is /dev/epoll scheduled for official inclusion anytime soon?
Date: Tue, 24 Jul 2001 12:41:15 -0700
Organization: Legato Systems, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello all.

I've been playing around with Davide Libenzi's "/dev/epoll" patch and have
been very impressed by the performance figures (see his paper at
http://www.xmailserver.org/linux-patches/nio-improve.html for some
numbers) - it seems to exhibit really excellent scaling.

Given the sheer utility of using /dev/epoll in a largescale server, are
there any plans to roll it into the mainline kernel at any point? If not,
why / is there an equivalent scheduled for inclusion?

Clearly, IMHO, Linux needs something that can scale as well as BSD's kqueue
and Solaris's /dev/poll. /dev/epoll seems to be an excellent answer.


Sincerely,
 David E. Weekly

PS: Cheers to Anton Altaparmikov's work on NTFS: In 2.4.7, we now have
rather robust read/write support of NT filesystems!


