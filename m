Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129313AbQKGX3k>; Tue, 7 Nov 2000 18:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129512AbQKGX3a>; Tue, 7 Nov 2000 18:29:30 -0500
Received: from sunny.pacific.net.au ([210.23.129.40]:40918 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S129313AbQKGX3U>; Tue, 7 Nov 2000 18:29:20 -0500
Date: Wed, 8 Nov 2000 10:29:13 +1100
From: David Luyer <david_luyer@pacific.net.au>
Message-Id: <200011072329.eA7NTDx17836@typhaon.pacific.net.au>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.0-test10 and X4.0.1 don't like each other on Libretto 110CT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having problems with X 4.0.1 and 2.4.0-test kernels on a Toshiba Libretto
110CT.  Is this likely to be related to a known problem or can someone
recommend some random intermediate kernel versions to try (binary elimination
avoiding known-bad kernel versions...)?

H/w: Toshiba Libretto 110CT (NM2160), Xircom CEM336 modem/ethernet
S/w: Debian woody as at Wed Nov 8, with old xserver-svga package for testing

Kernel                     xserver-xfree86 4.0.1-1    xserver-svga 3.3.6-10
2.4.0-test10               Fail                       OK
2.4.0-test4pre3            Fail                       OK
2.2.15 (Debian build)      OK                         OK

"Fail" here means X startup results in a blank LCD, unable to switch to 
text consoles either, SAK results in a screen full of previous graphics-mode
display on LCD, even if it was pre-reboot, at that screen it is possible to
type (although not to see the result), login, reboot the system, try a
different version of X, etc (as long as you can remember what you've typed).

Thanks for any help,
David.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
