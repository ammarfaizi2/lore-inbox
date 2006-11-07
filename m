Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932784AbWKGSA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbWKGSA2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932791AbWKGSA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:00:28 -0500
Received: from fgwiel01.wie.de.future-gate.com ([193.108.164.2]:5099 "EHLO
	fgwiel01.wie.de.future-gate.com") by vger.kernel.org with ESMTP
	id S932784AbWKGSA1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:00:27 -0500
Message-Id: <4550D7B2020000F10000528D@fgbsll01a.bsl.ch.future-gate.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 07 Nov 2006 19:00:02 +0100
From: "Ronny Bremer" <rbremer@future-gate.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: PCI card not detected on Intel 845G chipset
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
X-future-gate-MailScanner-Information: Please contact the ISP for more information
X-future-gate-MailScanner: Found to be clean
X-MailScanner-From: rbremer@future-gate.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, windows finds the card. I even check with Netgear to make sure they haven't changed the chipset.

Apparently, their support was wrong. I replaced the Netgear card with a different model and Linux finds it immediately.

I am still a bit confused but there is no way to blame the kernel on this one :-)

Thank you for taking time to look into this.

Ronny

>>> "John Stoffel" <john@stoffel.org> 11/02/06 3:55 PM >>>

Ronny> I recently installed 2.6.16 on a compaq evo PC running Intel
Ronny> 845G chipset. Kernel finds all major system devices (USB, VGA,
Ronny> etc) but fails to find the installed Netgear WG311T card in the
Ronny> PCI slot.  lspci doesn't even show this card.

Does Windows find this card?  And have you made sure you've got the
card propery seated in the slot?  Maybe you've got a bad connection,
or a 3.3v card in 5v slot.  In other words, check the hardware.  

Ronny> No error messages concerning the PCI bus appear in dmesg.
Ronny> The only weird thing is, that lspci shows this device:
Ronny> Unknown non-vga adapter
Ronny> with the ID 0200:7008

Wierd, but try using 'lspci -vvvvv' for even more details on this
unknown device.  

John

