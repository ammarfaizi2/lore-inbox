Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264525AbRFJNKy>; Sun, 10 Jun 2001 09:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264526AbRFJNKe>; Sun, 10 Jun 2001 09:10:34 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35338 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264525AbRFJNKY>; Sun, 10 Jun 2001 09:10:24 -0400
Subject: Re: [patch] ess maestro, support for hardware volume control
To: pfaffben@msu.edu
Date: Sun, 10 Jun 2001 14:08:56 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <877kyl2e4t.fsf@pfaffben.user.msu.edu> from "Ben Pfaff" at Jun 09, 2001 11:43:46 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1594xc-0006ZB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What can happen as I see it is that userspace #2, which wants to
> talk to a particular misc driver, actually ends up talking to a
> different one because the minor gets reassigned between reading
> /proc/misc to find out the number and mknoding and opening the
> device:

Looks true to me. So get a real misc device assigned for anything you use 8)


