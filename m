Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVGFPyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVGFPyY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 11:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVGFPyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 11:54:23 -0400
Received: from mail.bencastricum.nl ([213.84.203.196]:36785 "EHLO
	bencastricum.nl") by vger.kernel.org with ESMTP id S262314AbVGFLoy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 07:44:54 -0400
Date: Wed, 6 Jul 2005 13:44:05 +0200 (CEST)
From: Ben Castricum <benc@bencastricum.nl>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.13-rc2 Compile error in bt87x.c
Message-ID: <Pine.LNX.4.58.0507061342100.4612@gateway.bencastricum.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-bencastricum-MailScanner-Information: Please contact the ISP for more information
X-bencastricum-MailScanner: Found to be clean
X-MailScanner-From: benc@bencastricum.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  CC [M]  sound/pci/bt87x.o
sound/pci/bt87x.c: In function `snd_bt87x_detect_card':
sound/pci/bt87x.c:807: `driver' undeclared (first use in this function)
sound/pci/bt87x.c:807: (Each undeclared identifier is reported only once
sound/pci/bt87x.c:807: for each function it appears in.)
sound/pci/bt87x.c: At top level:
sound/pci/bt87x.c:910: `driver' used prior to declaration
make[2]: *** [sound/pci/bt87x.o] Error 1
make[1]: *** [sound/pci] Error 2
make: *** [sound] Error 2

My .config can be found at http://www.bencastricum.nl/.config

Hope this helps,
Ben
