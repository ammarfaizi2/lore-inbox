Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292390AbSBPPYN>; Sat, 16 Feb 2002 10:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292389AbSBPPYB>; Sat, 16 Feb 2002 10:24:01 -0500
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:11769 "EHLO
	filestore.kroptech.com") by vger.kernel.org with ESMTP
	id <S292390AbSBPPVj>; Sat, 16 Feb 2002 10:21:39 -0500
Message-ID: <019801c1b6fd$9df513f0$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: <esr@thyrsus.com>, "David Woodhouse" <dwmw2@infradead.org>
Cc: "Rob Landley" <landley@trommello.org>, "Dave Jones" <davej@suse.de>,
        "Larry McVoy" <lm@work.bitmover.com>,
        "Arjan van de Ven" <arjan@redhat.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20020216013538.A23546@thyrsus.com> <20020215135557.B10961@thyrsus.com> <20020215224916.L27880@suse.de> <20020215170459.A15406@thyrsus.com> <20020215232517.FXLQ71.femail38.sdc1.sfba.home.com@there> <20020216013538.A23546@thyrsus.com> <22614.1013851279@redhat.com> <20020216085706.H23546@thyrsus.com>
Subject: Re: Disgusted with kbuild developers
Date: Sat, 16 Feb 2002 10:21:33 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 16 Feb 2002 15:21:33.0622 (UTC) FILETIME=[9DF62560:01C1B6FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Eric S. Raymond" <esr@thyrsus.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: "Rob Landley" <landley@trommello.org>; "Dave Jones" <davej@suse.de>; "Larry
McVoy" <lm@work.bitmover.com>; "Arjan van de Ven" <arjan@redhat.com>;
<linux-kernel@vger.kernel.org>
Sent: Saturday, February 16, 2002 8:57 AM
Subject: Re: Disgusted with kbuild developers


> David Woodhouse <dwmw2@infradead.org>:
> > However - the thing to which I and many others object most strongly is the
> > rulebase policy changes which appear to be inseparable from the change in
> > mechanism. That is; we've tried to get you to separate them, and failed.
>
> Failed?  Hardly.
>
> The only rulebase policy change Tom Rini was able to identify in a recent
> review was the magic behavior of EXPERT with respect to entries without
> help.  Which I then removed by commenting out a single declaration.
>
> There is a widespread myth that the CML2 rulebase is lousy with "policy
> changes".  I don't know how it got started, but it needs to die now.

The last time I played with CML2 (~2 months ago) I didn't even make it through a
full 'make config' before I had to stop on account of nausea. It was seemingly
overrun with gratuitous changes that were (to me, anyway) useless and annoying.

Examples:
* It started asking me vague questions like how old my computer was in order to
draw some magic conclusion about my configuration needs. *I* know my hardware.
Don't waste my time with Aunt Tillie questions that will quite possibly draw the
wrong conclusion for my needs.

* The 'make config' UI was subtly changed from the CML1 version. Why? I haven't
seen any complaints on the list about the UI.

* The 'make menuconfig' UI was significantly changed. Again, why? Haven't seen
any complaints about the old one.

Maybe these issues don't qualify as "policy change" but it seems obvious that
there is some other agenda being followed here besides replacing the CML1
language with one that can accurately represent the rulebase. I'm in favor of
the later, but definitely not if it comes inseparably packaged with the former.

--Adam


