Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277918AbRKMSVk>; Tue, 13 Nov 2001 13:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277949AbRKMSVa>; Tue, 13 Nov 2001 13:21:30 -0500
Received: from mout02.kundenserver.de ([195.20.224.133]:42362 "EHLO
	mout02.kundenserver.de") by vger.kernel.org with ESMTP
	id <S277942AbRKMSVY>; Tue, 13 Nov 2001 13:21:24 -0500
From: "Sascha Andres" <linux-kernel@programmers-world.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Changed message for GPLONLY symbols
Date: Tue, 13 Nov 2001 19:22:28 +0100
Message-ID: <001401c16c70$27297590$0328a8c0@keasanb>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20011113113401.55b75a1b.reynolds@redhat.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i did not wrote much to this list yet, but i have a suggestion to this
hint:
> > Hint: You are trying to load a module which has unresolved symbols.
These
> >       symbols may not be exported by this version of the kernel
(perhaps
> >       you have a version mismatch), or they may be exported GPLONLY,
> >       (in which case they will not be available to your module which
does
> >       not carry a GPL compatible license). In either case, contact
> >       the *only* module supplier for assistance; no one else can
help you.
>              ^^^^
^^^^^^^^^^^^^^^^^^^^^^^^

when i read the last sentence i had the feeling of a bad taste,
just because is sounds just like 'the evil module supplier (which
might just not have recompiled his modules yet) is responsible
for all and everything'.

well, it sounds like that for me.

what's with this:

To avoid further problems please contact the module supplier as he can
help you best.

so the whole hint would look like:

Hint: You are trying to load a module which has unresolved symbols.
These
      symbols may not be exported by this version of the kernel (perhaps
      you have a version mismatch), or they may be exported GPLONLY,
      (in which case they will not be available to your module which
does
      not carry a GPL compatible license).
	To avoid further problems please contact the module supplier as
he can
	help you best.

that is - i think - a bit more polite and perhaps it helps to prevent
mails like 'your damn module causes serious errors with the actual
kernel.
can't you program like you ought to program'. at least that mails
will be more polite too.

bye,

sascha


