Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262669AbTCPNxi>; Sun, 16 Mar 2003 08:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262670AbTCPNxi>; Sun, 16 Mar 2003 08:53:38 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:6404 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S262669AbTCPNxi>; Sun, 16 Mar 2003 08:53:38 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303161406.h2GE6PGd000145@81-2-122-30.bradfords.org.uk>
Subject: 2.4 PS/2 mouse problem
To: vojtech@suse.cz
Date: Sun, 16 Mar 2003 14:06:25 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

I've just bought a new PS/2 mouse, and it works fine with 2.5, but in
2.4 it doesn't work properly if I move the mouse slowly.

I've tried 2.4.20-pre5, 2.4.20, and 2.4.19, and get the same
problems:

In X, the mouse works fine as long as it's moved quickly, but trying
to move it 1 pixel, for example, is almost impossible.

>From the console, cat /dev/psaux displays nothing, if I move the mouse
slowly, no matter how far it's moved.  Moving it quicky displays
characters as expected.

It's almost as if individual packets of data are being lost, but only
the first packet of a constant stream of data.  Maybe the mouse is
sending an extra syncronisation byte or something, which is confusing
things?

Is there a way to dump the raw data from the port like there is in
2.5?

John.
