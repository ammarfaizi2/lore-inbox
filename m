Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262170AbTCVLzQ>; Sat, 22 Mar 2003 06:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262402AbTCVLzQ>; Sat, 22 Mar 2003 06:55:16 -0500
Received: from cpe-024-033-021-148.midsouth.rr.com ([24.33.21.148]:60032 "EHLO
	braindead") by vger.kernel.org with ESMTP id <S262170AbTCVLzO>;
	Sat, 22 Mar 2003 06:55:14 -0500
From: Warren Turkal <wturkal@cbu.edu>
To: linux-kernel@vger.kernel.org
Subject: [BUG] laptop keyboard
Date: Sat, 22 Mar 2003 06:05:54 -0600
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303220605.54478.wturkal@cbu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not subscribed. Please cc on replies.

I have a Gateway 600 series notebook. I have been using and testing the 
developmental kernel for some time now. I have just noticed that my 
keyboard''s "fn" key combinations stop working upon booting 2.5.65. They 
worked as recently as 2.5.63 and I could not get 2.5.64 to compile cleanly. 
These key combinations are supposed to make various things happen on my 
laptop. I believe that they are controlled by the bios, as I can see results 
of some while on the bios load screen.

Fn-F1 - Labeled "Help"; don't know what it does
Fn-F2 - Labeled "Status"; used to show battery status in upper left
Fn-F3 - Labeled "LCD/CRT"; switch montior output among built in LCD, back
        monitor port, and both
Fn-F4 - Labeled "Standby"; used to function as the ACPI standby button
Fn-F9 - Labeled "Pad Lock"; think num lock; strangely, this one still
        work in 2.5.65
Fn-F10 - Labeled "Scroll Lock"
Fn-F11 - Labeled "Pause"
Fn-F12 - Labeled "Break"

I have tested that the Fn-F2 combination works in bios and grub and continues 
to work until the 2.5.65 kernel is loaded.

I think this is a regression in the keyboard handling for the 2.5.65 kernel.

Like I said before, all of the Fn combinations work in 2.5.63. If anyone has a 
patch from 2.5.63 to something after 2.5.64 that compiles, I would be happy 
to try it. I setup a bitkeeper clone of Linus's latest, so if someone could 
give me some bitkeeper magic to export diffs from 2.5.63 to 2.5.64 in a 
relavant directory (probably drivers/input/keyboard) maybe I could look to 
see what changed, although I don't know if I am skilled enough to find errors 
in the code.

Thanks, Warren Turkal
-- 
Treasurer, GOLUM, Inc.
http://www.golum.org

