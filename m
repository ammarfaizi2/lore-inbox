Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262891AbSIPUhb>; Mon, 16 Sep 2002 16:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262894AbSIPUha>; Mon, 16 Sep 2002 16:37:30 -0400
Received: from pcp748446pcs.manass01.va.comcast.net ([68.49.120.237]:63719
	"EHLO pcp748343pcs.manass01.va.comcast.net") by vger.kernel.org
	with ESMTP id <S262891AbSIPUha>; Mon, 16 Sep 2002 16:37:30 -0400
Date: Mon, 16 Sep 2002 16:42:23 -0400
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.35 mouse and keyboard flakiness report
Message-ID: <20020916204223.GA26923@bittwiddlers.com>
References: <20020909232641.GA736@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020909232641.GA736@bittwiddlers.com>
User-Agent: Mutt/1.4i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.62
Reply-To: Matthew Harrell 
	  <mharrell-dated-1032640943.c57dd3@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The same thing happens on 2.5.35 as on 2.5.3[3-4]

: 
: Running the attached config on my HP Pavilion zt1195 laptop I get some strange
: keyboard and mouse behavior.  First, when I first try to log into X the keyboard
: is a little wacky: alt behaves as Fn, m doesn't work at all, etc.  It seems 
: to go away after a bunch of key presses for no apparent reason.  I do get
: this from the kernel log
: 
:       atkbd.c: Unknown key (set 2, scancode 0xbc, on isa0060/serio0) pressed.
: 
: but that's about it.  Then when X windows starts first my mouse buttons have
: been reversed from the normal left handed behavior and then when I try to
: cut and paste the cut motion never turns off so subsequent movements of the
: mouse just keep trying to select regions from that first window.  Eventually
: I just have to reboot so I can actually work normally.
: 

-- 
  Matthew Harrell                          The best way to accelerate a 
  Bit Twiddlers, Inc.                       Macintosh is at 9.8 meters per
  mharrell@bittwiddlers.com                 second squared.
