Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285017AbRL3VDe>; Sun, 30 Dec 2001 16:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284987AbRL3VDZ>; Sun, 30 Dec 2001 16:03:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65033 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285000AbRL3VDK>; Sun, 30 Dec 2001 16:03:10 -0500
Subject: Re: [PATCH] Balanced Multi Queue Scheduler ...
To: jjs@pobox.com (J Sloan)
Date: Sun, 30 Dec 2001 21:12:51 +0000 (GMT)
Cc: timothy.covell@ashavan.org, skraw@ithnet.com (Stephan von Krawczynski),
        davidel@xmailserver.org (Davide Libenzi),
        Dieter.Nuetzel@hamburg.de (Dieter =?ISO-8859-1?Q?N=FCtzel?=),
        rml@tech9.net (Robert Love),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <3C2F7D49.9040606@pobox.com> from "J Sloan" at Dec 30, 2001 12:47:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16KnGF-0002WU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On my 4-way ppro, make -j4 is much faster
> than a simple "make" for kernel compilation.
> Almost linearly so -

Make does lots of I/O and also has lots of stuff that can run in parallel
and balance out easily. The real test case for you to try are 5, 6, 7, and 8
copies of seti
