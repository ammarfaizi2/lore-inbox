Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbVHMXaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbVHMXaF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 19:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbVHMXaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 19:30:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28907 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932407AbVHMXaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 19:30:01 -0400
Date: Sat, 13 Aug 2005 19:29:57 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: IDE CD problems in 2.6.13rc6
Message-ID: <20050813232957.GE3172@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed this week whilst trying to encode a bunch
of audio CDs to oggs that my boxes running the latest
kernels are having serious issues, whereas 2.6.12 seems
to cope just fine.

The symptoms vary. On some of my machines just inserting
an audio CD makes the box instantly lock up.
If I boot with the same CD in the drive, sound-juicer
can read it just fine. When I get to the next CD, I have
to reboot again, or it locks up.

On another box, it gets stuck in a loop where it
just prints out..

hdc: irq timeout: status=0xd0 { Busy }    (This line sometimes has status=0xc0)
ide: failed opcode was: unknown

The net result is that I've not got a single box that
will read audio CDs without doing something bad, and I've
tried it on several quite diverse systems.


I'll try and narrow down over the next few days when this
started happening, but IDE / CD folks may have some better
ideas about which changes were suspicious.

		Dave

