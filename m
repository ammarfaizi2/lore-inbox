Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129322AbQKOC2k>; Tue, 14 Nov 2000 21:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129193AbQKOC2U>; Tue, 14 Nov 2000 21:28:20 -0500
Received: from [62.172.234.2] ([62.172.234.2]:47933 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129322AbQKOC2E>;
	Tue, 14 Nov 2000 21:28:04 -0500
Date: Wed, 15 Nov 2000 01:59:24 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: linux-kernel@vger.kernel.org
Subject: test11-pre5 breaks vmware
In-Reply-To: <CD314F06B1A@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.21.0011150157410.930-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

You probably noticed this already but I just wanted to bring it to your
attention that /usr/bin/vmware-config.pl script needs updating since the
flags in /proc/cpuinfo is now called "features" so it otherwise fails
complaining that my 2xP6 has no tsc. Trivial change but still worthy of
propagating into your latest .tar.gz file for 2.4.x

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
