Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271055AbRHOGDx>; Wed, 15 Aug 2001 02:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271053AbRHOGDo>; Wed, 15 Aug 2001 02:03:44 -0400
Received: from mail.fbab.net ([212.75.83.8]:27920 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S271056AbRHOGDf>;
	Wed, 15 Aug 2001 02:03:35 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: torvalds@transmeta.com linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 8.936139 secs)
Message-ID: <3e4101c12550$50f242b0$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <200108150532.f7F5WGq01653@penguin.transmeta.com>
Subject: Re: 2.4.8 Resource leaks + limits
Date: Wed, 15 Aug 2001 08:05:42 +0200
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

"Linus Torvalds" <torvalds@transmeta.com> wrote in message
news:200108150532.f7F5WGq01653@penguin.transmeta.com...
> In article <3ce801c12548$b7971750$020a0a0a@totalmef> you write:
> >
> >Question: why isn't there a limit for global memory usage per user?
>
> Answer: because traditionally Linux (or UNIX) hasn't had a good and
> efficient way to have per-user statistics.
>

Well this problem is not so hard, i'll just set "nproc = maxglobal / data"
or something like that for now.
Too bad if any of my users want to run many diet processes, but that's life.

The more serious part of my little alloc adventure is much more dangerous:

Whattaheck happened to my resources?
I _still_ can't log in to that box as a luser (root works).

[snip]
> Linus
>

Magnus

