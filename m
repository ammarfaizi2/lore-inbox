Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280239AbRJaOca>; Wed, 31 Oct 2001 09:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280246AbRJaOcU>; Wed, 31 Oct 2001 09:32:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13071 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280245AbRJaOcL>; Wed, 31 Oct 2001 09:32:11 -0500
Subject: Re: 2.2.19 memory problems
To: mcartoaj@mat.ulaval.ca (Mihai Cartoaje)
Date: Wed, 31 Oct 2001 14:35:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BE0061D.C8834AEB@mat.ulaval.ca> from "Mihai Cartoaje" at Oct 31, 2001 09:09:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ywSy-0003sl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> memory other than is normal at start-up. Then I ran free and it
> reported 15MB of swap memory was still being used. I have a 16MB
> machine and a minimal install which sometimes reports less than
> 1.5MB used at start-up -- RAM, that is, not swap. I think this is a
> problem with 2.2 memory handling.

The kernel will not remove stuff from swap until it is needed. It went to
the trouble of putting it out on disk, it gains nothing from copying it back
until (or if ever) needed
