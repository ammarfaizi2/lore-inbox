Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265374AbUBARPi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 12:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265378AbUBARPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 12:15:38 -0500
Received: from nevyn.them.org ([66.93.172.17]:16000 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S265374AbUBARPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 12:15:37 -0500
Date: Sun, 1 Feb 2004 12:15:26 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Cc: neilb@cse.unsw.edu.au
Subject: RAID arrays not reconstructing in 2.6
Message-ID: <20040201171525.GA2092@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw this a couple of weeks ago in a 2.6.0-test kernel, and today in
2.6.2-rc3.  When I have to hit the hard reset button on my desktop, whose
root filesystem is RAID5 on /dev/md0, it comes back up cleanly - no
reconstruction.

Have we gotten a whole lot more enthusiastic about marking superblocks clean
lately, or should I be worried?  Obviously this always used to trigger
reconstruction, until recently.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
