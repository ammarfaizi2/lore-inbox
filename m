Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272000AbTHDRhn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 13:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272001AbTHDRhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 13:37:43 -0400
Received: from palrel10.hp.com ([156.153.255.245]:24299 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S272000AbTHDRhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 13:37:41 -0400
Date: Mon, 4 Aug 2003 10:37:39 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200308041737.h74HbdCf015443@napali.hpl.hp.com>
To: linux-ia64@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: milstone reached: ia64 linux builds out of Linus' tree
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of this morning, Linus's current bk tree
(http://linux.bkbits.net:8080/linux-2.5) builds and works out of the
box for ia64!

Thanks to everybody who helped make this happen.  In particular,
thanks to Andrew Morton and Christoph Hellwig for their efforts, and
Andy Grover for a last-minute ACPI patch!

For maximum performance/stability, I'd still recommend to use the
ia64-specific patches, but for someone who needs to build bleeding
edge kernels for multiple architectures, being able to use Linus' tree
should make it a lot easier to include ia64 in their regular testing
etc.

Now that Linus' tree works for ia64, the next question is how we can
keep it that way.  I think it would be useful to have someone setup a
cron job which does daily builds/automated tests off of Linus tree.
If something breaks, the person doing this could perhaps come up with
a minimal patch which gets Linus' tree to build again (and submit a
patch to the appropriate maintainer, with cc to the linux-ia64 list).
I plan on continuing to put out roughly monthly ia64-specific patches
and during those normal cycles, I'd then integrate the "quick fix up"
patches as needed.  Does this sound reasonable?  Anybody want to
volunteer for this "Linus watchdog" role?

	--david
