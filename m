Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbTDVBli (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 21:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbTDVBlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 21:41:37 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:17370 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S262739AbTDVBlh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 21:41:37 -0400
Date: Tue, 22 Apr 2003 02:45:52 +0100 (BST)
From: Jon Masters <jonathan@jonmasters.org>
To: linux-kernel@vger.kernel.org
cc: jcm@jonmasters.org
Subject: PPC ELF Runtime Relocation
Message-ID: <Pine.LNX.4.10.10304220231380.2862-100000@router>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need some advice on some specifics of arch/ppc/kernel/setup.c

There is some code I am working on which works correctly with OpenFirmware
and makes client interface calls to do setup as expected however in the
final arrangement it (like Linux) is not loaded at the original link
address. I need therefore to do something similar to the kludge used in
PPC Linux during early_init.

I cannot simply relocate the code to the link address as that will nuke
the OF interface before I am done using package instances therein.

Would a resident guru please get in touch off list if able to help.

Cheers,

Jon.

P.S. I apologise if I should have asked this question in a more PPC
specific forum - please let me know privately if so, where I should post.

