Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263425AbTJ0QDy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 11:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbTJ0QDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 11:03:54 -0500
Received: from pushme.nist.gov ([129.6.16.92]:37370 "EHLO postmark.nist.gov")
	by vger.kernel.org with ESMTP id S263425AbTJ0QDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 11:03:52 -0500
To: linux-kernel@vger.kernel.org
Subject: APM suspend still broken in -test9
References: <9cfbrs7d695.fsf@rogue.ncsl.nist.gov>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Mon, 27 Oct 2003 11:03:30 -0500
Message-ID: <9cfekwy8y7h.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I reported this also on -test8:
http://marc.theaimsgroup.com/?l=linux-kernel&m=106694328730337&w=2

and it was confirmed by two other people in that thread.  I just
tested it again with -test9.  Putting my laptop to sleep while X is
running, then resuming, locks the machine hard.  Suspend works fine
without X (plain old console mode).

The three machines reported so far:

 - Fujitsu P-2120 (me)
 - Gericom        ( Oliver Bohlen <oliver.bohlen () t-online ! de> )
 - Thinkpad R40   ( Ruben Puettmann <ruben () puettmann ! net> )

Both Ruben and I have agp configured; he has a Radeon while I have a
r128 (Rage Mobility M).  I don't know more about Oliver's config.

Can anyone else verify this?  Everything worked fine in -test7; things
broke in -test8 and are still broken in -test9.  Nothing appears in
the logs (which is to be expected if we crash while resuming... where
would it get logged?).

Ian

