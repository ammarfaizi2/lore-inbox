Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314686AbSD1JZo>; Sun, 28 Apr 2002 05:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314687AbSD1JZn>; Sun, 28 Apr 2002 05:25:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17416 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314686AbSD1JZn>; Sun, 28 Apr 2002 05:25:43 -0400
Subject: Re: Why HZ on i386 is 100 ?
To: george@mvista.com (george anzinger)
Date: Sun, 28 Apr 2002 10:12:26 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ak@suse.de (Andi Kleen),
        linux-kernel@vger.kernel.org
In-Reply-To: <3CCB9080.EA1E0DB0@mvista.com> from "george anzinger" at Apr 27, 2002 11:02:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E171kjK-0003oh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> so, what?  We will have a timer interrupt prior to the slice end, and
> will have to make this decision all over again.  However, the real rub

Only on unusual occasions.

> is that we have to keep track of elapsed time and account for that (i.e.
> shorten the remaining slice) not only in the timer interrupt, but each

We do anyway

Alan
