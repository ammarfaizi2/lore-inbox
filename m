Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbUBVXfu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 18:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbUBVXfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 18:35:50 -0500
Received: from smtp2.att.ne.jp ([165.76.15.138]:27594 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S261230AbUBVXfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 18:35:48 -0500
Message-ID: <008d01c3f99c$9033e3c0$34ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Jamie Lokier" <jamie@shareable.org>
Cc: <linux-kernel@vger.kernel.org>
References: <18de01c3f93f$dc6d91d0$b5ee4ca5@DIAMONDLX60> <20040222204541.GA26793@mail.shareable.org>
Subject: Re: UTF-8 filenames
Date: Mon, 23 Feb 2004 08:35:19 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier replied to me:

> > Consider
> > converting all your ASCII filenames to UTF-16.  Let everyone share the
> > short-term pain for the long-term gain.  When you get everyone to agree on
> > UTF-16, it will be ugly, but it will be equal for everyone.
>
> UTF-8 is the only sane universal encoding in unix.

That's a bit beside the point.  I was replying to the assertion that
everyone agreed to use UTF-8.  (And particularly, for large character sets.)

> UTF-16 is not an option;

Of course.  Perhaps my use of reductio al absurdum was unclear.  I was
trying to show that UTF-8, despite its sanity, is not universally agreeable.
The actual reason is because it came late to the scene (around 20 years ago)
and it is not backwards compatible.  But to make the point, I compared it
with UTF-16 which is equally not universally agreeable.

> it's not POSIX compatible,

OK, UTF-8 has one less reason than UTF-16 has, for being not universally
agreeable.  But the biggest reason still remains, as mentioned above.

> > By the way, another subthread mentioned that stty puts some stuff in the
> > kernel that could be done in user space.  In Unix systems the same is true
> > for IMEs, stty options specify the encoding of the output of an IME (e.g.
> > EUC-JP or SJIS, which then gets forwarded as input to shells, applications,
> > etc.), and whether a single backspace (or whatever character deletion
> > character) deletes an entire input character instead of just deleting a
> > single byte, etc.  I keep forgetting to see if Linux has the same stty
> > options.  I haven't needed to set them with stty because if I need to use a
> > different locale then I just open a new terminal emulator window using that
> > locale.
>
> Do you have a list or description of the specific stty options that
> are used?

Well, I thought I described them as I saw them used in Unix.  I no longer
have access to machines running commercial Unix systems, but some of the
stty options were the way I did describe.  I have a feeling that System V
might have implemented them slightly differently from BSD-based systems, but
regardless, the same functionality was pretty much "universally" needed and
implemented.

If you're asking whether I noticed similar stty options in Linux, I didn't
notice because of the reason mentioned (I just opened another terminal
emulator window using the locale that I temporarily needed).  But I'll try
to remember to look next weekend.  Sorry, I'm leaving for work in a minute
and can't look now.

