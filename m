Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318870AbSHLXds>; Mon, 12 Aug 2002 19:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318873AbSHLXds>; Mon, 12 Aug 2002 19:33:48 -0400
Received: from hibernia.clubi.ie ([212.17.32.129]:26763 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S318870AbSHLXdm>; Mon, 12 Aug 2002 19:33:42 -0400
Date: Tue, 13 Aug 2002 00:45:09 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Rik van Riel <riel@conectiva.com.br>
cc: Manik Raina <manik@cisco.com>, Willy Tarreau <willy@w.ods.org>,
       Jim Roland <jroland@roland.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Re: The spam problem.
In-Reply-To: <Pine.LNX.4.44L.0208121057180.23404-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0208130039120.26478-100000@fogarty.jakma.org>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
X-Dumb-Filters: aryan marijuiana cocaine heroin hardcore cum pussy porn teen tit sex lesbian group
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002, Rik van Riel wrote:

> Little chance.  These messages are generally written in such a way
> that there are no useful regexps to distinguish the 419 spam from
> legitimate email.

use a procmail scoring filter, case sensitive, and score a la:

* 5^6 ([nN]igeria|[Aa]bacha|[zZ]imbabwe|[mM]ugabe)
* 10^6 (MUGABE|MILLION|DOLLARS|NIGERIA|ABACHA|ZIMBABWE)

most of my mail will start with a default score of at least -50. and
above catches 90ish% of 419 spam to me. no reason why spamassassin
couldnt do this too. (presuming it has weighted scoring like
procmail).

[paul@fogarty tmp]$ wc -l ~/.procspam
    493 /home/paul/.procspam

and i plan to add the multi-k lines nl.linux.org anti-spam regexps to 
it some time too. :)

> Rik

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
That's the true harbinger of spring, not crocuses or swallows
returning to Capistrano, but the sound of a bat on a ball.
		-- Bill Veeck

