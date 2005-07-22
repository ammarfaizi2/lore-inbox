Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVGVCae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVGVCae (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 22:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVGVCad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 22:30:33 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:47850 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262018AbVGVCaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 22:30:30 -0400
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>,
       "Kyle Moffett" <mrmacman_g4@mac.com>, "Paul Jackson" <pj@sgi.com>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>, <linux@horizon.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: kernel guide to space
References: <20050714011208.22598.qmail@science.horizon.com>
	<FD559B50-FB1E-4478-ACF4-70E4DB7A0176@mac.com>
	<Pine.LNX.4.61.0507200715290.9066@yvahk01.tjqt.qr>
	<20050720174521.73c06bce.pj@sgi.com>
	<3FC51285-941F-48B6-B5A9-1BBE95CCD816@mac.com>
	<9a874849050721114227f3c6a7@mail.gmail.com>
	<Pine.LNX.4.61.0507211528250.12675@chaos.analogic.com>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Fri, 22 Jul 2005 11:29:55 +0900
In-Reply-To: <Pine.LNX.4.61.0507211528250.12675@chaos.analogic.com> (linux-os@analogic.com's message of "Thu, 21 Jul 2005 15:37:44 -0400")
Message-Id: <buozmsfvaho.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:
> It will take probably an hour to parse:
> struct BusLogic_FetchHostAdapterLocalRAMReguest FetchHostAdapterLocalRAMRequest
>  		^!)

Agh!  My eyes!

The above names are way overdone by any measure, but is there any
consensus whether studly-caps in general are discouraged or not?

CodingStyle is vague on the issue, though it kind of implies you should
use underscores when multiple words are needed (the sole example of
studly caps is in a negative context, and a following recommended name
uses underlines).  The kernel source seems pretty random -- they get
used here and there, but more often not; they seem more common in older
code.

If they are discouraged, it might be better to say so explicitly, as
there are many programmers these days who are used to using them.

-Miles
-- 
Run away!  Run away!
