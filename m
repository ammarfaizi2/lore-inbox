Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbVBBUTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVBBUTH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 15:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVBBULj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 15:11:39 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:27780 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262450AbVBBTqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:46:09 -0500
Date: Wed, 2 Feb 2005 20:46:22 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, vojtech@ucw.cz
Subject: [bk-patches] [resend] Needed input fixes for 2.6.11
Message-ID: <20050202194622.GA3794@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I pretty much screwed up in the last update you merged for 2.6.11,
making USB input devices rather annoying to use. These four patches fix
the damage made:

1) The MUX mode disabling had a bug that caused it to not work at
   all.

2) MSC_SCAN events backpropagating into hid-input.c caused a flood
   of 'event field not found' messages in the syslog.

3) USB keyboad LEDs stopped working due to a fix for Logitech mouse
   fake LEDs.

4) The fourth patch is a documentation update from Andries Brouwer.

Please include these before the final 2.6.11, or drop the last input
update.

As usual, they're available at:

	bk://kernel.bkbits.net/vojtech/for-linus

as well as in the following mails of this thread.

Thanks,
-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
