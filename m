Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161149AbWGIVHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbWGIVHB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161152AbWGIVHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:07:01 -0400
Received: from mx2.rowland.org ([192.131.102.7]:65041 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1161149AbWGIVG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:06:59 -0400
Date: Sun, 9 Jul 2006 17:06:57 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: linux-input@atrey.karlin.mff.cuni.cz,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Magic Alt-SysRq change in 2.6.18-rc1
Message-ID: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry:

Are you the right person to handle changes in the behavior of Alt-SysRq?

Before 2.6.18-rc1, I used to be able to use it as follows:

	Press and hold an Alt key,
	Press and hold the SysRq key,
	Release the Alt key,
	Press and release some hot key like S or T or 7,
	Repeat the previous step as many times as desired,
	Release the SysRq key.

This scheme doesn't work any more, or if it does, the timing requirements
are now much stricter.  In practice I have to hold down all three keys at
the same time; I can't release the Alt key before pressing the hot key.

This makes thinks very awkward on my laptop machine.  Its keyboard
controller doesn't seem to like having three keys pressed simultaneously.  
Instead of the expected hotkey behavior, I usually got an error message
from atkbd warning about too many keys being pressed.  Getting it to work
as desired is hit-and-miss.

I would really appreciate going back to the old behavior, where only two 
keys needed to be held down at any time.

Alan Stern

