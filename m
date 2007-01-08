Return-Path: <linux-kernel-owner+w=401wt.eu-S1161207AbXAHKNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161207AbXAHKNy (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 05:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbXAHKNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 05:13:54 -0500
Received: from mx.laposte.net ([81.255.54.11]:38102 "EHLO mx.laposte.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161207AbXAHKNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 05:13:53 -0500
Message-ID: <19480.192.54.193.51.1168251206.squirrel@rousalka.dyndns.org>
Date: Mon, 8 Jan 2007 11:13:26 +0100 (CET)
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
To: linux-kernel@vger.kernel.org
Cc: "Russell King" <rmk+lkml@arm.linux.org.uk>
User-Agent: SquirrelMail/1.4.8-2.fc6
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> elinks is one such program.  It now assumes UTF-8 _only_ displays.
> That's no better than programs which assume ISO-8859-1 only or US-ASCII
> only.

That's way better than programs:
- which assume an encoding you can't write most world languages in (BTW
ISO-8859-1 & US-ASCII are broken by design for Western Europe since at
least the Euro creation)
- which perpetuate the myth local 8-bit encodings are manageable (they
aren't, people spent decades trying to limp along with them, unicode &
UTF-8 where not created just to make your life miserable)

Show me one program that spurns Unicode I'll show you one that "passed on"
iso-8859-15 (typically, though it's the easiest non-iso-8859-1 to do)

The only reason you have the UTF-8 big stick approach nowadays is people
have tried for years to get app writers manage 8-bit locales properly to
dismal results. The old system was only working for en_US users (and
perhaps to .uk people)

-- 
Nicolas Mailhot

