Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVA2TOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVA2TOv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVA2TMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:12:38 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:207 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261545AbVA2TIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:08:15 -0500
Date: Sat, 29 Jan 2005 17:44:50 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, vojtech@ucw.cz
Subject: [PATCH 0/3] - Three more input fixes for 2.6.11
Message-ID: <20050129164450.GA14053@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The previous set introduced one bug, mostly harmless, but pretty
annoying - the hid-input driver fills the logs with the 'event field not
found' message. I'm sorry for that, I just tested that the patch does
what it should and didn't check the logs.

The last of these three patches fixes that.

The first fixes the MUX disabling routine in i8042 to really do
something on reboot, and the second patch from Andries adds a
documentation entry for atkbd.softraw.

Please include them before 2.6.11, as the bug described above would
cause a lot of e-mails to be sent to me.

The patches are available at

	bk://kernel.bkbits.net/vojtech/for-linus

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
