Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129875AbRBTUwv>; Tue, 20 Feb 2001 15:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130687AbRBTUwl>; Tue, 20 Feb 2001 15:52:41 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:65029 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129875AbRBTUw3>; Tue, 20 Feb 2001 15:52:29 -0500
Subject: Re: [PATCH] 2.4.1-ac UP-APIC updates
To: mingo@redhat.com (Ingo Molnar)
Date: Tue, 20 Feb 2001 20:55:14 +0000 (GMT)
Cc: mikpe@csd.uu.se (Mikael Pettersson), alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl
In-Reply-To: <Pine.LNX.4.32.0102201343490.7613-100000@devserv.devel.redhat.com> from "Ingo Molnar" at Feb 20, 2001 01:46:18 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VJoa-0000f1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i dont like this one. 100 times a second makes absolutely no performance
> difference whatsoever - but eg. i'm driving kernel profiling from the NMI
> handler to get profiles of eg. IRQ handlers and other cli()-ed code areas.

So set it to 100Hz as a debugging option like slab debugging
