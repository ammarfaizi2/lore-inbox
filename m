Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbRGEPzw>; Thu, 5 Jul 2001 11:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265878AbRGEPzn>; Thu, 5 Jul 2001 11:55:43 -0400
Received: from proton.llumc.edu ([143.197.200.1]:36052 "EHLO proton.llumc.edu")
	by vger.kernel.org with ESMTP id <S265841AbRGEPz3>;
	Thu, 5 Jul 2001 11:55:29 -0400
From: "Don Krause" <dkrause@optivus.com>
To: "'Ronald Bultje'" <rbultje@ronald.bitfreak.net>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: >128 MB RAM stability problems (again)
Date: Thu, 5 Jul 2001 08:51:47 -0700
Message-ID: <036e01c1056a$665b0d40$6cc8c58f@satoy>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
In-Reply-To: <994279551.1116.0.camel@tux>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can someone please
> point out to me
> that he's actually running kernel-2.4.x on a machine with
> more than 128
> MB RAM and that he's NOT having severe stability problems?
> And can that same person PLEASE point out to me why 2.4.x is
> crashing on
> me (or help me to find out...)?

%uname -a
Linux cartman 2.4.0-64GB-SMP #1 SMP Wed Jan 24 15:52:30 GMT 2001 i686
unknown
%uptime
 8:35am  up 57 days, 12:42,  2 users,  load average: 2.00, 2.00, 2.00
%free
             total      used      free      shared      buffers      cached
Mem:        254904    251968      2936           0        92224       45028
-/+ buffers/cache:    114716    140188
Swap:       524656     14192    510464


Could this be a 2.4 swap issue. You NEED at least RAM x2 swap. If you're
just adding memory to
a box that's stable with 128 megs and possibly 256 megs swap (you don't
state, just guessing..)
you've now got too little swap, and boom, stability goes bye-bye.

Just haven't seen the swap issue mentioned this thread...

=Don=

