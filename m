Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266028AbUGENK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266028AbUGENK1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 09:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbUGENK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 09:10:27 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:37900 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S266028AbUGENKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 09:10:06 -0400
Date: Mon, 5 Jul 2004 15:10:02 +0200
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: 2.6.7-mm6 and usb deadlock (and synaptics)
Message-ID: <20040705131002.GA14768@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

With 2.6.7-mm6 my laptop stops working completely. Ooops while booting.

Reverting
- usb-locking-fix.patch
- bk-usb.patch
makes it work.

Yre you interested in the output of the kernel oops? I could recompile
the `bad' kernel and copy the Oops by hand from the screen.


BTW: With 2.6.7-mm6 my synaptics touchpad is not recognized anymore at
boot time from the driver. Is this done somewhere in the usb stuff?

And X does not start because it cannot find the synaptics stuff. Have
there been any changes in this area?

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
OUGHTERBY (n.)
Someone you don't want to invite to a party but whom you know you have
to as a matter of duty.
			--- Douglas Adams, The Meaning of Liff
