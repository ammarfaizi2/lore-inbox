Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283244AbRLXWuQ>; Mon, 24 Dec 2001 17:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283268AbRLXWuH>; Mon, 24 Dec 2001 17:50:07 -0500
Received: from mailc.telia.com ([194.22.190.4]:39643 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S283244AbRLXWt6>;
	Mon, 24 Dec 2001 17:49:58 -0500
To: rct@gherkin.frus.com (Bob_Tracy)
Cc: linux-kernel@vger.kernel.org
Subject: Re: "sr: unaligned transfer" in 2.5.2-pre1
In-Reply-To: <m16IMMg-0005khC@gherkin.frus.com>
From: Peter Osterlund <petero2@telia.com>
Date: 24 Dec 2001 23:48:55 +0100
In-Reply-To: <m16IMMg-0005khC@gherkin.frus.com>
Message-ID: <m2wuzcdyjs.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rct@gherkin.frus.com (Bob_Tracy) writes:

> > So, what changes are needed to make CD support work?
> 
> Evidently non-trivial...  I tried a quick hack at putting the
> sr_scatter_pad() code back into sr.c, but without success: null
> pointer dereference when I tried to mount an ISO9660 CD.  I think
> I'll enjoy the holiday week and wait for Jens to produce the proper
> fix :-).

Sorry for bothering the list with this, but your mail server is
rejecting my emails to you, claiming they are SPAM.

   ----- The following addresses had permanent fatal errors -----
<rct@gherkin.frus.com>
    (reason: 555 rct@gherkin.frus.com rejects SPAM from petero2@telia.com)

   ----- Transcript of session follows -----
... while talking to news.wlk.com.:
>>> RCPT To:<rct@gherkin.frus.com>
<<< 555 rct@gherkin.frus.com rejects SPAM from petero2@telia.com
554 5.0.0 Service unavailable

    [ Part 2: "Delivery Status" ]

Reporting-MTA: dns; mailb.telia.com
Received-From-MTA: DNS; d1o89.telia.com
Arrival-Date: Mon, 24 Dec 2001 23:28:55 +0100 (CET)

Final-Recipient: RFC822; rct@gherkin.frus.com
Action: failed
Status: 5.0.0
Remote-MTA: DNS; news.wlk.com
Diagnostic-Code: SMTP; 555 rct@gherkin.frus.com rejects SPAM from
petero2@telia.com
Last-Attempt-Date: Mon, 24 Dec 2001 23:29:38 +0100 (CET)

-- 
Peter Österlund             petero2@telia.com
Sköndalsvägen 35            http://w1.894.telia.com/~u89404340
S-128 66 Sköndal            +46 8 942647
Sweden
