Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAEUdy>; Fri, 5 Jan 2001 15:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129818AbRAEUdq>; Fri, 5 Jan 2001 15:33:46 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:50698 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S129324AbRAEUd2>; Fri, 5 Jan 2001 15:33:28 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: "Matthew D. Pitts" <mpitts@suite224.net>
cc: linux-kernel@vger.kernel.org
Message-ID: <862569CB.0070DDEE.00@smtpnotes.altec.com>
Date: Fri, 5 Jan 2001 14:33:12 -0600
Subject: Re: Change of policy for future 2.2 driver submissions
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Either I'm blind, or especially dense today, or both (quite possible :-) but I
don't see any reference in patch-kernel to the extra version information.
EXTRAVERSION is defined in the kernel Makefile, and I tried using the script
found in the 2.4.0-test1 source like this:

patch-kernel /usr/src/linux /pub/linux/kernel/v2.4/test-kernels

but the test-2 and following patches are not applied.  All I get is "Current
kernel version is 2.4.0."  What am I missing?

Wayne




"Matthew D. Pitts" <mpitts@suite224.net> on 01/05/2001 12:50:26 PM

To:   Wayne Brown/Corporate/Altec@Altec
cc:   linux-kernel@vger.kernel.org

Subject:  Re: Change of policy for future 2.2 driver submissions




Wayne,

The versions of patch-kernel included in 2.3/2.4 support extra version
information, so patches from Linus and others (i.e. Alan Cox) can be applied
if proper information is placed in the kernel Makefile.

Matthew D. Pitts
mpitts@suite224.net






-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
