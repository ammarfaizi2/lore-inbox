Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263583AbTJWOxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 10:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTJWOxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 10:53:44 -0400
Received: from [63.161.72.3] ([63.161.72.3]:49536 "HELO
	mail.standardbeverage.com") by vger.kernel.org with SMTP
	id S263583AbTJWOxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 10:53:41 -0400
Message-ID: <0683fa04294bcbb820b3719af9c56cb7@stdbev.com>
Date: Thu, 23 Oct 2003 09:52:33 -0500
From: "Jason Munro" <jason@stdbev.com>
Subject: Unkown key pressed 2.6.0-test8
To: linux-kernel@vger.kernel.org
Reply-to: <jason@stdbev.com>
X-Mailer: Hastymail 0.7
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   I'm having trouble with the keyboard on my Toshiba Satellite 1410-S173
with 2.6.0-test8. It frequently locks the keyboard for 5-10 seconds and
produces these messages:

atkbd.c: Unknown key pressed (translated set 0, code 0x2, data 0x41, on
isa0060/serio0).
atkbd.c: Unknown key pressed (translated set 2, code 0x66, data 0xe, on
isa0060/serio0).

This is during normal typing (this email for example). Looking at atkbd.c I
see that there is a "Workaround Toshiba laptop multiple keypress" in
atkbd_interrupt(), line #262, however this does not seem to fix my problem.
I remember this came up on the list in the past but searching the archive
provided no definitive resolution (or I missed it!). I can provide any
other needed info or testing.

Any suggestions?

Thanks

\_____ Jason Munro ________________________
 \_____ jason@stdbev.com ___________________
  \_____ #hastymail at irc.freenode.net _____
   \_____ http://hastymail.sourceforge.net ___

