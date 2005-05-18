Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVERNsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVERNsB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 09:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVERNqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 09:46:09 -0400
Received: from main.gmane.org ([80.91.229.2]:58562 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262188AbVERNpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:45:52 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ian Soboroff <isoboroff@acm.org>
Subject: ACPI S3/APM suspend
Date: Wed, 18 May 2005 09:10:42 -0400
Message-ID: <9cfvf5gel2l.fsf@rogue.ncsl.nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: rogue.ncsl.nist.gov
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:CG0QIvysuUQqiksMOM2hKYkUfoY=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I recently reinstalled my laptop (Fujitsu P2110) with RHEL4, and I
found that neither ACPI S3 or APM suspend (booting with acpi=off) work
reliably with their stock kernel (a 2.6.9 derivative).  Sometimes
resuming works, but more often the computer locks up, or the keyboard
doesn't function respond.

APM suspend worked fine on the last kernel I tried it with (stock
2.6.3) but I think the last time I tried a newer vanilla kernel
(around 2.6.9 time), it didn't work.  I don't think I've ever seen
Linux ACPI S3 suspend work reliably on this laptop, but since APM was
always so solid I didn't test it much.

Have there been any improvements in this area in more recent Linus
kernels?  Any patches floating around which fix suspend-to-ram
problems?

Thanks,
Ian


