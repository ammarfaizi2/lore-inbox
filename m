Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbVHaMhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbVHaMhF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 08:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbVHaMhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 08:37:05 -0400
Received: from [81.2.110.250] ([81.2.110.250]:54400 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932514AbVHaMhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 08:37:04 -0400
Subject: Re: [FINAL WARNING] Removal of deprecated serial functions -
	please update your drivers NOW
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, amax@us.ibm.com,
       ralf@linux-mips.org, starvik@axis.com
In-Reply-To: <20050831103352.A26480@flint.arm.linux.org.uk>
References: <20050831103352.A26480@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 31 Aug 2005 14:00:24 +0100
Message-Id: <1125493224.3355.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-08-31 at 10:33 +0100, Russell King wrote:
> Unfortunately, it appears that some of these drivers do not contain
> email addresses for their maintainers, neither are they listed in
> the MAINTAINERS file.  (mwavedd and serial_txx9).

I'll have a quick look at mwave. If I remember rightly it just needs to
tell someone that an "ISA" 16450 serial port materialised by magic at
the addresses it selected.

The mwave firmware is loaded into a DSP and until its loaded there isn't
a serial port.

