Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbTISXJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 19:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTISXJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 19:09:57 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:9224 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S261807AbTISXJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 19:09:01 -0400
Message-ID: <8F12FC8F99F4404BA86AC90CD0BFB04F039F7147@mail-sc-6.nvidia.com>
From: Allen Martin <AMartin@nvidia.com>
To: "'Merlin Hughes'" <lnx@merlin.org>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] 2.4.23-pre4 add support for udma6 to nForce IDE drive
	r
Date: Fri, 19 Sep 2003 16:08:55 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since applying your patch, however, I've managed to run such
> a dd, with zcav thrown in, with complete relability at UDMA133
> for several hours without problems.

While I'm certainly happy to hear that, I don't think I can take credit.
Nothing in the patch should help with system stability issues.

Do you have ACPI turned on?  Look at /proc/interrupts and see if any PCI
interrupts are set to edge triggered mode.  That's the #1 cause of stability
problems on nForce systems.

-Allen
