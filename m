Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUAMHzv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 02:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbUAMHzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 02:55:50 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:26532 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261464AbUAMHzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 02:55:48 -0500
To: linux-kernel@vger.kernel.org
Subject: Where are 2.6.x upgrade notes?
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 13 Jan 2004 02:55:46 -0500
Message-ID: <87ptdocmf1.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to upgrade to 2.6.1 and running into a number of roadblocks. Before
I start asking stupid questions on mailing lists I'm wonder if there's a
document that lists the typical problems people will run into upgrading?

So far I've bumped into and knew or found how to solve:

. Need to install module-init-tools package

. Need to migrate modules.conf to modprobe.conf
  In my case it doesn't load sound drivers without it

. Alsa starts muted (Everyone knows that right?)

I still have a few problems that I'm stumped on:

. I still get no sound even though every channel is unmuted and the volume
  raised and there are no errors.

  Incidentally, which version of Alsa is included in 2.6.1? Is it the 1.0.1
  release? Or a pre 1.0 release? There are no version numbers anywhere that I
  can find in the dmesg output or the source.

. Mouse wheel doesn't work in X

Surely these are common problems that everyone's faced and there's a simple
Upgrade FAQ somewhere like there was with 2.4?

-- 
greg

