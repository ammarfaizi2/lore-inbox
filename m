Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131733AbRDJMiD>; Tue, 10 Apr 2001 08:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRDJMhp>; Tue, 10 Apr 2001 08:37:45 -0400
Received: from [212.115.175.146] ([212.115.175.146]:4089 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S131666AbRDJMf4>; Tue, 10 Apr 2001 08:35:56 -0400
Message-ID: <27525795B28BD311B28D00500481B7601F11A6@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [RFC] FW: proposal for systems that do not require security
Date: Tue, 10 Apr 2001 14:35:52 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an idea: I have a couple of linux-systems running in a intranet which
is not connected to do outside world in any way. Since they're only used for
calculations for which there is no harm if anyone would tamper with them,
security is not neccessary. The only thing important, is performance. Huge
amounts of data must be transferred inbetween these boxes.
So, I was wondering: isn't it a nice idea to have a switch in the
configuration menu to disable entropy-gathering in the interrupt-routines,
have some simplistic routine (like x'=(x * m + a) % p) which returns a non-
cryptographic value, and something similar symplistic for the network-
traffic routines?

Thank you.


Folkert van Heusden
[ www.vanheusden.com ]
