Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132175AbRBESns>; Mon, 5 Feb 2001 13:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132382AbRBESnk>; Mon, 5 Feb 2001 13:43:40 -0500
Received: from clueserver.org ([206.163.47.224]:61188 "HELO clueserver.org")
	by vger.kernel.org with SMTP id <S132175AbRBESn2>;
	Mon, 5 Feb 2001 13:43:28 -0500
Date: Mon, 5 Feb 2001 10:54:50 -0800 (PST)
From: Alan Olsen <alan@clueserver.org>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Matrox Marvell G400
In-Reply-To: <20010205113157.A5980@animx.eu.org>
Message-ID: <Pine.LNX.4.10.10102051048230.29593-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2001, Wakko Warner wrote:

> How well is this card supported for it's capture capabilities and dual head?

The capture features are undocumented and unsupported (to my knowledge).
As far as I have heard, the Rainbow Runner card is not supported in Linux
and Matrox has no plans of doing it.

As for the dual monitor...

You need XFree86 4.0.1 or later.  Matrox has drivers for 4.0.1.  The last
time I checked, they did not have anything that compiles under 4.0.2.
Dual monitor mode works with xinerama as long as you are at the same
resolution and color depth.  (I have it working on my machine here.  The
Matrox driver docs tell how to make it work. It is not hard.)

I have noticed some visual problems on the second screen under 4.0.2.
(Ugly, but usable.)  Not certain when that will get fixed.  Due to Matrox
using a proprietary library (HALlib), there is not alot of effort being
put into making it work right.  (Kind of working in the dark at this
point...)

This is more of a question for the xpert list on xfree86.org.

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
    "In the future, everything will have its 15 minutes of blame."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
