Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273204AbRIWVps>; Sun, 23 Sep 2001 17:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273440AbRIWVpk>; Sun, 23 Sep 2001 17:45:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40964 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273622AbRIWVpd>; Sun, 23 Sep 2001 17:45:33 -0400
Subject: Re: [PATCH] tty canonical mode: nicer erase behaviour
To: nyh@math.technion.ac.il (Nadav Har'El)
Date: Sun, 23 Sep 2001 22:50:16 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), zefram@fysh.org,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010923234111.A16873@leeor.math.technion.ac.il> from "Nadav Har'El" at Sep 23, 2001 11:41:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15lH8i-0000W3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Debian's solution isn't a silver bullet, in my opinion... It just means the
> ^H/^? confusion stops being a problem in a stand-alone system (if all your
> applications and configuration files come as defaults from Debian, they are
> consistent) but it just increased the mess when you log in from one system
> type to another (one of them being none-Linux Unix)...

Thats in many ways a design flaw in the protocols. Original telnet has
IAC sequences to send a "delete" regardless of keymapping policies that
are not known at end points. X also does it right with the keysyms.
Ssh seems to lack this
