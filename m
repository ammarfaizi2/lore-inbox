Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264146AbTFPTBu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 15:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbTFPTBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 15:01:50 -0400
Received: from mail.casabyte.com ([209.63.254.226]:49673 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S264146AbTFPTBt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 15:01:49 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: continuous backtrace ... ?
Date: Mon, 16 Jun 2003 12:15:41 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGCEPICPAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have a 2.5.70 kernel image which, at boot, goes into a continuously
looping backtrace.  It scrolls up the screen too fast and continuously to
read but it is clearly a backtrace. If I just relax and watch I can see the
[bracketed hex] and routine name shape of it whizzing by.

This happens while the file systems are read only and the system doesn't
respond to the keyboard at all.

Is there any good way to capture this stream of data in any kind of useful
way?  or at least pause the spew so that I can find the general locus of the
problem?

Given the immediacy of the problem (it appears just-about-concurrently with
attempt to draw the boot logo) I suspect that it has something to do with
the console driver (radeon frame buffer VGA console in normal mode)
interacting with my All-In-Wonder 9700 pro and the very new P4-3ghz in
hyperthreading mode.


Rob.

P.S. I realize suddenly that I should at least include the .config file but
the machine is at home and turned off just now... 8-)

