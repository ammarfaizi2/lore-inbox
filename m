Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284586AbRLRSwo>; Tue, 18 Dec 2001 13:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284553AbRLRSvQ>; Tue, 18 Dec 2001 13:51:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19728 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284664AbRLRStt>; Tue, 18 Dec 2001 13:49:49 -0500
Subject: Re: Scheduler ( was: Just a second ) ...
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 18 Dec 2001 18:58:45 +0000 (GMT)
Cc: david@cobite.com (David Mansfield),
        wli@holomorphy.com (William Lee Irwin III),
        linux-kernel@vger.kernel.org (Kernel Mailing List),
        jgarzik@mandrakesoft.com (Jeff Garzik)
In-Reply-To: <Pine.LNX.4.33.0112180922500.2867-100000@penguin.transmeta.com> from "Linus Torvalds" at Dec 18, 2001 09:27:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16GPRt-0008HU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe the best thing to do is to educate the people who write the sound
> apps for Linux (somebody was complaining about "esd" triggering this, for
> example).

esd is a culprit, and artsd to an extent. esd is scheduled to die so artsd
is the big one to tidy. Kernel side OSS is dead so its a matter for ALSA
