Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264794AbSKEKoy>; Tue, 5 Nov 2002 05:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264793AbSKEKoy>; Tue, 5 Nov 2002 05:44:54 -0500
Received: from ns.tasking.nl ([195.193.207.2]:62480 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S264794AbSKEKov>;
	Tue, 5 Nov 2002 05:44:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15815.41594.832084.553425@koli.tasking.nl>
Date: Tue, 5 Nov 2002 11:50:34 +0100
From: Kees Bakker <rnews@altium.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.45 + usb uhci oopses and panics
X-Mailer: VM 7.03 under Emacs 20.7.2
Reply-To: kees.bakker@altium.nl (Kees Bakker)
Organisation: ALTIUM Software B.V.
X-Bill: Go away
X-Attribution: kb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.5.45 I am not able to boot anymore. If I disable USB the oopses and
panics are gone. I've rebooted a few time but the result is not always the
same. Sometimes it panics in reap_timer_fnc with Aiee, killing interrupt
handler! Or it gives an OOPS at _devfs_search_dir. And I've also seen it
spit out many messages
 "uhci_transfer_result: called for for URB dfc80940 not in flight?"

My machine has a MSI K7T266 Pro motherboard with Athlon 1.3GHz. It has a
VIA chipset, 82C686b+VT8233. Harddisk: IBM Deskstar 60GXP, 40Gb.

I'm using CONFIG_USB_UHCI_HCD_ALT=y

		Kees
-- 
