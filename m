Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277541AbRKSK3O>; Mon, 19 Nov 2001 05:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277533AbRKSK3F>; Mon, 19 Nov 2001 05:29:05 -0500
Received: from mailout5-1.nyroc.rr.com ([24.92.226.169]:43657 "EHLO
	mailout5.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S277532AbRKSK2t>; Mon, 19 Nov 2001 05:28:49 -0500
Message-ID: <003901c170e3$3b119660$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "Tim Connors" <tcon@physics.usyd.edu.au>,
        =?iso-8859-1?Q?Fran=E7ois_Cami?= <stilgar2k@wanadoo.fr>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.3.96.1011119210005.12304A-100000@suphys.physics.usyd.edu.au>
Subject: Re: Swap
Date: Mon, 19 Nov 2001 05:16:19 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If you don't have swap, maybe one, or both of the two
> > kernel trees will end up being not cached into main
> > memory, depending on how much RAM left you have. but going
> > back to X will take 1 second instead of 20,
> > and thus the system will be more responsive.

> A perfect example of why a system _needs_ tuning knobs - this view of
> Linus's that we need a self tuning system is idiotic, because some of us
> don't care how long a kernel compile takes (or even how long it takes to
> serve a couple of web pages per hour), but _do_ care about the general
> system responsiveness.

For what it's worth, I heartily agree...

Linus et al might very well say "if you care so much about keeping X in RAM,
just mlock() it." This is certainly worth a shot. (though I'd much prefer a
configurable 'weight' or 'stickiness' for file mappings vs. cached buffers).

Of course this sort of second-order tuning mechanism is a lot less important
than having a VM that doesn't crash or suck badly for common loads =)...
(not that the VM has been bad at all lately; I haven't had any problems
since 2.4.9-ac10 or 2.4.14, knock on wood...)

Regards,
Dan

