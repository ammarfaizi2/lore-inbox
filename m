Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbVA0RDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbVA0RDh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVA0RCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:02:30 -0500
Received: from news.suse.de ([195.135.220.2]:36558 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262667AbVA0Q7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:59:47 -0500
Date: Thu, 27 Jan 2005 17:59:58 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Subject: [bk patches] Input update for 2.6.11 [0/6]
Message-ID: <20050127165958.GA15690@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm sending you a few fixes hopefully for the 2.6.11 release. They
should fix reboot problems due to the BIOS not expecting the i8042
controller to be in MUX mode, problems with incorrectly assigned buttons
on mice with horizontal scroll wheels, spurious kernel messages and
endless message loops on disconnect of HID devices on UHCI controllers,
and some nuances regarding MSC_SCAN events generation for future tools
for assigning keycodes to scancodes.

You can pull the whole set, including merge changesets from

	bk://kernel.bkbits.net/vojtech/for-linus

I'll be sending a larger bunch of patches sometime soon, but those
aren't as urgent as these six.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
