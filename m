Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312096AbSCQSjc>; Sun, 17 Mar 2002 13:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312098AbSCQSjZ>; Sun, 17 Mar 2002 13:39:25 -0500
Received: from mail010.mail.bellsouth.net ([205.152.58.30]:58063 "EHLO
	imf10bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S312094AbSCQSjO>; Sun, 17 Mar 2002 13:39:14 -0500
Message-ID: <00a301c1cde2$fa76fed0$0100a8c0@DELLXP1>
From: "Ken Hirsch" <kenhirsch@myself.com>
To: "Anton Altaparmakov" <aia21@cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <5.1.0.14.2.20020317170621.00abd980@pop.cus.cam.ac.uk>
Subject: Re: fadvise syscall?
Date: Sun, 17 Mar 2002 13:35:35 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov writes
> Posix or not I still don't see why one would want that. You know what you
> are going to be using a file for at open time and you are not going to be
> changing your mind later. If you can show me a single _real_world_ example
> where one would genuinely want to change from one access pattern to
another
> without closing/reopening a particular file I would agree that fadvise is
a
> good idea but otherwise I think open(2) is the superior approach.
>

Sure, a database manager can change the access pattern on every query.  If
there's an index and not too many records are expected to match, it will use
a random pattern, otherwise it will use sequential access.





