Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268347AbRGWU6P>; Mon, 23 Jul 2001 16:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268343AbRGWU6G>; Mon, 23 Jul 2001 16:58:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22545 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268344AbRGWU5t>; Mon, 23 Jul 2001 16:57:49 -0400
Subject: Re: user-mode port 0.44-2.4.7
To: cfriesen@nortelnetworks.com (Chris Friesen)
Date: Mon, 23 Jul 2001 21:57:07 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), andrea@suse.de (Andrea Arcangeli),
        jdike@karaya.com (Jeff Dike),
        user-mode-linux-user@lists.sourceforge.net (user-mode-linux-user),
        linux-kernel@vger.kernel.org (linux-kernel), jh@suse.cz (Jan Hubicka)
In-Reply-To: <no.id> from "Chris Friesen" at Jul 23, 2001 04:44:06 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15OmlH-0007R9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Suppose I loop against xtime reaching a particular value.  While this is

xtime isnt used this way that I can see. jiffies however is. There are good
arguments for getting rid of most [ab]use of jiffies however. For one its
pretty important to scaling on both big mainframes and beowulf setups doing
heavy computation to reduce timer ticks
