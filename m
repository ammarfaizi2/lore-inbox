Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268020AbRGZPFK>; Thu, 26 Jul 2001 11:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268026AbRGZPFA>; Thu, 26 Jul 2001 11:05:00 -0400
Received: from spring.webconquest.com ([66.33.48.187]:10756 "HELO
	mail.webconquest.com") by vger.kernel.org with SMTP
	id <S268020AbRGZPEv>; Thu, 26 Jul 2001 11:04:51 -0400
Date: Thu, 26 Jul 2001 11:04:48 -0400 (EDT)
From: <sentry21@cdslash.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Weird ext2fs immortal directory bug
In-Reply-To: <Pine.LNX.3.95.1010726105812.16941A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.30.0107261104220.18300-100000@spring.webconquest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> On Thu, 26 Jul 2001 sentry21@cdslash.net wrote:
> [SNIPPED...]
> >
> > Here's the problem(s) (or at least, the symptoms):
> >
> > sentry21@Petra:1:/lost+found$ ls -l
> > total 0
> > lr----S---    1 52       12337           0 Nov  1  2022 #3147 ->
> >
>
> Did you try..
> # rm -r lost+found
> # mklost+found
>
> Without knowing how to use the ext2fs tools, and not wanting to
> risk more damage, I tried this and it worked when I had such a
> crash-induced problem.

sentry21@Petra:1:/$ sudo rm -rf lost+found/
rm: cannot unlink `lost+found/#3147': Operation not permitted
rm: cannot remove directory `lost+found': Directory not empty


Dang.

--Dan

