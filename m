Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264461AbRGWXRo>; Mon, 23 Jul 2001 19:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264489AbRGWXRY>; Mon, 23 Jul 2001 19:17:24 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53266 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264461AbRGWXRN>; Mon, 23 Jul 2001 19:17:13 -0400
Subject: Re: user-mode port 0.44-2.4.7
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 24 Jul 2001 00:13:17 +0100 (BST)
Cc: cfriesen@nortelnetworks.com (Chris Friesen),
        andrea@suse.de (Andrea Arcangeli), jdike@karaya.com (Jeff Dike),
        user-mode-linux-user@lists.sourceforge.net (user-mode-linux-user),
        linux-kernel@vger.kernel.org (linux-kernel), jh@suse.cz (Jan Hubicka)
In-Reply-To: <Pine.LNX.4.33.0107231552000.7916-100000@penguin.transmeta.com> from "Linus Torvalds" at Jul 23, 2001 03:53:38 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Oot3-0007eD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> PS. This has come up before. The old pre-Alan networking code had
> "volatile" on just about every single network data structure. Every damn
> single one of them was a bug. Without exception.

With due respect to Fred and Ross most of them were there because the
gcc 2.4.5 compiler was buggy.

Nowdays we still have some volatile users - notably jiffies, and one or two
of them make sense, but not many

Alan
