Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266964AbTBLIR7>; Wed, 12 Feb 2003 03:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbTBLIR7>; Wed, 12 Feb 2003 03:17:59 -0500
Received: from ishtar.tlinx.org ([64.81.58.33]:29109 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id <S266964AbTBLIR6>;
	Wed, 12 Feb 2003 03:17:58 -0500
From: "LA Walsh" <law@tlinx.org>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-security-module@wirex.com>
Subject: RE: [BK PATCH] LSM changes for 2.5.59
Date: Wed, 12 Feb 2003 00:27:42 -0800
Message-ID: <002c01c2d270$9ca89820$1403a8c0@sc.tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <b28k4f$hp4$1@abraham.cs.berkeley.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: David Wagner
> LA Walsh wrote:
> >	Maybe I'm delusional, but you are contradicting yourself.  In
> >common terms, this is called lying.
> 
> No, he's not; even if he were, no, it's not.  Can't we do
> without the personal attacks and just stick to technical topics?
---
	I'm sorry if you feel it was a personal attack.  It seemed
the appropriate noun for someone to whom this discrepancy in charter
has been pointed out to before and who worked to silence those
pointing out the discrepancy in public.

	That cast it into the light of deliberate conflicting statements
which I used the common word "lie", but perhaps more politically
correct would have been to say that I was confused by the apparent
contradiction of the two statements.  

	One says 'simple'/'generic', the other says 'access checks only
as implemented as patches on top of the questionable and vague
policies that already exist.  One deliberate design decision was to
make the hooks "non-authoritative" which makes the resulting
security policies as clean and easy to read as mud.  It also made
writing a clean/simple security policy impossible, with "kludges"
suggested like "well just always override DAC checks with priviledges"
and then do the real checks in the 'restrictive-only' LSM calls.

	Please explain to me how this is simple or generic.

	It's completely inappropriate for a security structure where
increased complexity yields increased failure and lower ability
to prove (confidence).


> >	Security isn't just an afterthought you can patch on and cross
> >your fingers and hope it won't break.  It has to be designed in.  
> 
> People keep telling you that LSM does have a careful design for
> security.  I suspect what you really mean is that you don't like
> the design we chose -- but that's different.
---
	Please read what I said carefully.  I didn't say that the 
"patched on security" wasn't carefully designed.  I made no claims
about how carefully it was designed.  Carefulness of design avails
you not, if the design isn't appropriate for the problem space.

-l

