Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317456AbSFRPsS>; Tue, 18 Jun 2002 11:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317458AbSFRPsR>; Tue, 18 Jun 2002 11:48:17 -0400
Received: from 01-048.118.popsite.net ([66.19.120.48]:260 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S317456AbSFRPsQ>;
	Tue, 18 Jun 2002 11:48:16 -0400
Date: Tue, 18 Jun 2002 11:48:16 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: System halted - or is it?  (2.4.19-pre10-ac2)
Message-ID: <20020618154816.GA20823@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using 2.4.19-pre10-ac2 on both my desktop and laptop now.  It works
great, with one "interesting" exception: on halt, it first stops the RAID on
my desktop (lots of messages about invalidating busy buffers here), then
flushes all IDE devices, and then prints System Halted... and then gives me
back my shell prompt.  The system appears to still work, at least for
trivial operations.  The shell is definitely still running.

Any ideas?

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
