Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbTIARbe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTIARbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:31:33 -0400
Received: from ha84s013.d.shentel.net ([204.111.84.13]:47246 "EHLO
	charon.int.bittwiddlers.com") by vger.kernel.org with ESMTP
	id S263081AbTIARav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:30:51 -0400
Date: Mon, 1 Sep 2003 13:31:03 -0400
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test? ppp problems
Message-ID: <20030901173050.GA3387@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.82 (Needles)
X-Primary-Address: mharrell@bittwiddlers.com
Reply-To: Matthew Harrell 
	  <mharrell-dated-1062869464.d56e67@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I haven't been able to get pppd to work with any of the 2.6.0 kernels even
though it works with the same setup under my 2.5.75 kernel.  I'm getting
the error

  pppd[1336]: pppd 2.4.1 started by mharrell, uid 1000
  chat[1350]: Can't get terminal parameters: No such device
  pppd[1336]: Connect script failed
  pppd[1336]: tcsetattr: No such device

The device does exist, though, and I can access it fine through minicom.  I've
tried it with both devfs turned on and off and it doesn't seem to make a 
difference.  I'm not getting any unusual messages in the kernel log

  CSLIP: code copyright 1989 Regents of the University of California
  PPP generic driver version 2.4.2

Any idea what's going on?  Since the config is rather long I just put it
online here

        http://alecto.bittwiddlers.com/files/config

Thanks

-- 
  Matthew Harrell                          I no longer need to punish, deceive,
  Bit Twiddlers, Inc.                       or compromise myself, unless I want
  mharrell@bittwiddlers.com                 to stay employed.
