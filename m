Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVCRI5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVCRI5k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 03:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVCRI5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 03:57:40 -0500
Received: from mailgw1.technion.ac.il ([132.68.238.34]:63937 "EHLO
	mailgw1.technion.ac.il") by vger.kernel.org with ESMTP
	id S261515AbVCRI5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 03:57:20 -0500
Date: Fri, 18 Mar 2005 10:57:14 +0200 (IST)
From: Jacques Goldberg <goldberg@phep2.technion.ac.il>
X-X-Sender: goldberg@localhost.localdomain
Reply-To: Jacques Goldberg <Jacques.Goldberg@cern.ch>
To: linux-kernel@vger.kernel.org
Subject: Need break driver<-->pci-device automatic association
Message-ID: <Pine.LNX.4.58_heb2.09.0503181042470.8660@localhost.localdomain>
X-MailKey: 829.36.63
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Not subscribing because this is a one time question.
 Please Cc: to the reply address above , Jacques.Goldberg@cern.ch

 Several winmodem devices come with a hardware burnt-in identification
misleading the system to load the serial driver.
 As a result, it is not possible to load the special driver because the
PCI device is grabbed by the serial driver.

 Question: is there a way, as of kernels 2.6.10 and above, to release the
device from the serial driver, without having to recompile the kernel?

 We know how to attain the goal by patching 8250_pci.c but doing this will
quickly generate chaos. We know to detect the condition in the custom
driver. The fix would be trivial if we could  break the tie with the
serial driver.

                                            Thanks - Jacques
