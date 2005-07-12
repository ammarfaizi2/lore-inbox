Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVGLR2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVGLR2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 13:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVGLR0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 13:26:38 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:56962 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261709AbVGLRZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 13:25:06 -0400
Date: Tue, 12 Jul 2005 19:25:04 +0200
To: linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>,
       Andrew Morton <akpm@osdl.org>
Subject: synaptics touchpad not recognized by Xorg X server with recent -mm kernels
Message-ID: <20050712172504.GD24820@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter, hi Andrew!

Since 2.6.13-rc2-mm1 my X does not find my synaptics touchpad driver.

With kernel 2.6.13-rc2-mm2 (same with rc2-mm1) I get from the kernel:

Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9d48b1, caps: 0x904713/0x4006
input: SynPS/2 Synaptics TouchPad on isa0060/serio1

and Xorg.0.log gives:

(II) Synaptics touchpad driver version 0.14.2
touchpad no synaptics event device found (checked 10 nodes)
touchpad The evdev kernel module seems to be missing
Query no Synaptics: 6003C8
(EE) touchpad no synaptics touchpad detected and no repeater device
(EE) touchpad Unable to query/initialize Synaptics hardware.
(EE) PreInit failed for input device "touchpad"

(but evdev is definitely loaded!)


WIth 2.6.13-rc1-mm1 I get:

Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9d48b1, caps: 0x904713/0x4006
input: SynPS/2 Synaptics TouchPad on isa0060/serio1

and Xorg.0.log gives:

(II) Synaptics touchpad driver version 0.14.2
(--) touchpad auto-dev sets device to /dev/input/event1
(--) touchpad touchpad found

Any idea what could be the reason for this?

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining AT logic DOT at>             Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SITTINGBOURNE (n.)
One of those conversions where both people are waiting for the other
one to shut up so they can get on with their bit.
			--- Douglas Adams, The Meaning of Liff
