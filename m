Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129761AbQLJMAl>; Sun, 10 Dec 2000 07:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129812AbQLJMAW>; Sun, 10 Dec 2000 07:00:22 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:48644 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S129761AbQLJMAP>; Sun, 10 Dec 2000 07:00:15 -0500
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200012101129.DAA05519@cx518206-b.irvn1.occa.home.com>
Subject: Re: Traffic storm interaction with MacOS 8.6
To: j.d.morton@lancaster.ac.uk (Jonathan Morton)
Date: Sun, 10 Dec 2000 03:29:46 -0800 (PST)
Cc: linux-kernel@vger.kernel.org
Reply-To: barryn@pobox.com
In-Reply-To: <l0313030bb658f80c3180@[192.168.239.101]> from "Jonathan Morton" at Dec 10, 2000 10:07:42 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Setup:
> 	Client A is a PowerMac 8100/80 with a G3 CPU upgrade, MacOS 8.6
[snip]

MacOS 9.0.4 has many TCP fixes, including a vulnerability that allowed a
packet storm denial of service. Can you reproduce the problem with that
version of MacOS? (If you can't run 9.0.4 for some reason, there's an
Open Transport update available for 9.0 with the fixes, but your Mac is
too old to run it under 8.6.)

[Actually, it's possible to hack it into running under 8.6 on an older
machine, but (disregarding any legal ramifications which I'm too tired to
think about now) it introduces some weird glitches, and I *really* would
not recommend it -- also, I forget how I hacked it into working on an
older machine; I *think* the hacking procedure involved using an OS 9 CD
at some point in the process.]

-Barry K. Nathan <barryn@pobox.com>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
