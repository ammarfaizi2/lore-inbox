Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289017AbSAUDWZ>; Sun, 20 Jan 2002 22:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289021AbSAUDWQ>; Sun, 20 Jan 2002 22:22:16 -0500
Received: from jik-0.dsl.speakeasy.net ([66.92.77.120]:8832 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id <S289017AbSAUDWH>; Sun, 20 Jan 2002 22:22:07 -0500
Date: Sun, 20 Jan 2002 22:21:55 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
Message-Id: <200201210321.g0L3Lt602171@jik.kamens.brookline.ma.us>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-pre3-ac2 messing up CMOS clock?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any possibility that something in 2.4.18-pre3-ac2 might be
missing up the CMOS clock on my machine (SuperMicro S2DGU motherboard)
where 2.2.19+IDE wasn't?

I'm asking because two odd things started happening recently: (1) my
clock started drifting a lot (i.e., ntpd is resetting it frequently)
and (2) I kept getting BIOS errors during boot about the CMOS clock
being unset.

I assumed that the problem was caused by a dead clock battery, so I
replaced the battery.  But it just happened again.

This leaves me with three guesses for what may be causing the problem:
(1) something different about the kernel I started running recently;
(2) something different about Red Hat Rawhide software I just
installed on my machine; or (3) a broken motherboard.

I'd like to try to eliminate (1) or (2) as a possibility before trying
to get SuperMicro and/or the company that sold me the computer to say
anything useful about (3) :-).

Thanks for any advice you can provide.
