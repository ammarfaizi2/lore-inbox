Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbTAOJsq>; Wed, 15 Jan 2003 04:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266091AbTAOJsq>; Wed, 15 Jan 2003 04:48:46 -0500
Received: from mars.mj.nl ([81.91.1.49]:23531 "HELO mars.mj.nl")
	by vger.kernel.org with SMTP id <S266069AbTAOJsp>;
	Wed, 15 Jan 2003 04:48:45 -0500
Subject: Change PCMCIA card insert beep pitch?
From: Thomas Hood <jdthood@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1042624252.8124.49.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 15 Jan 2003 10:58:46 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a minor issue, but still needs some discussion.

When a PCMCIA card is inserted there is one beep.  After
configuration there is another beep.  The beep is lower
in pitch if configuration is unsuccessful.  In Windows,
the beep is higher in pitch otherwise.

In Linux, the second tone is at the same pitch as the
first tone if configuration is successful.

On one hand it would be nice if the two operating systems
provided feedback in the same way; on the other hand one
doesn't want to change Linux's current behavior for no
good reason.

I have long preferred the Windows way, because it provides
less ambiguous feedback.  When I was having trouble with
a network card I would eject and insert it, and I was
sometimes unsure whether the last beep I heard was the
third or the fourth (which might be delayed by a long
time if the DHCP client has a long timeout) -- especially
if there had been some terminal bells or other sounds in
the meantime.

If you have an opinion about this but don't want to 
waste l-k bandwidth, you can send your comment to me
and I will forward a summary to David Hinds (via PCMCIA
bug report #605529 at SourceForge).

-- 
Thomas Hood <jdthood@yahoo.co.uk>

