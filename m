Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263479AbRFAM3b>; Fri, 1 Jun 2001 08:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263481AbRFAM3W>; Fri, 1 Jun 2001 08:29:22 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:35344 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S263479AbRFAM3Q>;
	Fri, 1 Jun 2001 08:29:16 -0400
Message-ID: <938F7F15145BD311AECE00508B7152DB034C467A@vts007.vertis.nl>
From: Rolf Fokkens <FokkensR@vertis.nl>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: BUG: kernel-2.4.5: "Flags; bus-master 1, dirty ..."
Date: Fri, 1 Jun 2001 14:28:36 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Sometimes syslog suddenly starts to log a lot of messages, an example is
included. So far I get the impression that this is vortex related (I do have
a 3c905b).

Rolf

...
May 28 23:15:25 linux06 kernel:   Flags; bus-master 1, dirty 15505(1)
current 15505(1) 
May 28 23:15:25 linux06 kernel:   Transmit list 00000000 vs. ce44a240. 
May 28 23:15:25 linux06 kernel:   0: @ce44a200  length 800005ea status
800105ea 
May 28 23:15:25 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   3: @ce44a2c0  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   4: @ce44a300  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   6: @ce44a380  length 800000de status
000100de 
May 28 23:15:25 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   8: @ce44a400  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   9: @ce44a440  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   10: @ce44a480  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   11: @ce44a4c0  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   12: @ce44a500  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   15: @ce44a5c0  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   Flags; bus-master 1, dirty 15515(11)
current 15515(11) 
May 28 23:15:25 linux06 kernel:   Transmit list 00000000 vs. ce44a4c0. 
May 28 23:15:25 linux06 kernel:   0: @ce44a200  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   3: @ce44a2c0  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   4: @ce44a300  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   6: @ce44a380  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   8: @ce44a400  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   9: @ce44a440  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   10: @ce44a480  length 800005ea status
800105ea 
May 28 23:15:25 linux06 kernel:   11: @ce44a4c0  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   12: @ce44a500  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   15: @ce44a5c0  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   Flags; bus-master 1, dirty 15551(15)
current 15553(1) 
May 28 23:15:25 linux06 kernel:   Transmit list 00000000 vs. ce44a5c0. 
May 28 23:15:25 linux06 kernel:   0: @ce44a200  length 800005ea status
800105ea 
May 28 23:15:25 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:15:25 linux06 kernel:   3: @ce44a2c0  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   4: @ce44a300  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   6: @ce44a380  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   8: @ce44a400  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   9: @ce44a440  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   10: @ce44a480  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   11: @ce44a4c0  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   12: @ce44a500  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   15: @ce44a5c0  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   Flags; bus-master 1, dirty 15557(5)
current 15557(5) 
May 28 23:15:26 linux06 kernel:   Transmit list 00000000 vs. ce44a340. 
May 28 23:15:26 linux06 kernel:   0: @ce44a200  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   3: @ce44a2c0  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   4: @ce44a300  length 800005ea status
800105ea 
May 28 23:15:26 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   6: @ce44a380  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   8: @ce44a400  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   9: @ce44a440  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   10: @ce44a480  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   11: @ce44a4c0  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   12: @ce44a500  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   15: @ce44a5c0  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   Flags; bus-master 1, dirty 15589(5)
current 15589(5) 
May 28 23:15:26 linux06 kernel:   Transmit list 00000000 vs. ce44a340. 
May 28 23:15:26 linux06 kernel:   0: @ce44a200  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   3: @ce44a2c0  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   4: @ce44a300  length 800005ea status
800105ea 
May 28 23:15:26 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   6: @ce44a380  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   8: @ce44a400  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   9: @ce44a440  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   10: @ce44a480  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   11: @ce44a4c0  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   12: @ce44a500  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   15: @ce44a5c0  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   Flags; bus-master 1, dirty 15593(9)
current 15593(9) 
May 28 23:15:26 linux06 kernel:   Transmit list 00000000 vs. ce44a440. 
May 28 23:15:26 linux06 kernel:   0: @ce44a200  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   3: @ce44a2c0  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   4: @ce44a300  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   6: @ce44a380  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   8: @ce44a400  length 800005ea status
800105ea 
May 28 23:15:26 linux06 kernel:   9: @ce44a440  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   10: @ce44a480  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   11: @ce44a4c0  length 800005ea status
000105ea 
May 28 23:15:26 linux06 kernel:   12: @ce44a500  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   15: @ce44a5c0  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   Flags; bus-master 1, dirty 15626(10)
current 15628(12) 
May 28 23:15:27 linux06 kernel:   Transmit list 00000000 vs. ce44a480. 
May 28 23:15:27 linux06 kernel:   0: @ce44a200  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   3: @ce44a2c0  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   4: @ce44a300  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   6: @ce44a380  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   8: @ce44a400  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   9: @ce44a440  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   10: @ce44a480  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   11: @ce44a4c0  length 800005ea status
800105ea 
May 28 23:15:27 linux06 kernel:   12: @ce44a500  length 800000de status
000100de 
May 28 23:15:27 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   15: @ce44a5c0  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   Flags; bus-master 1, dirty 15632(0)
current 15632(0) 
May 28 23:15:27 linux06 kernel:   Transmit list 00000000 vs. ce44a200. 
May 28 23:15:27 linux06 kernel:   0: @ce44a200  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   3: @ce44a2c0  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   4: @ce44a300  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   6: @ce44a380  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   8: @ce44a400  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   9: @ce44a440  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   10: @ce44a480  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   11: @ce44a4c0  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   12: @ce44a500  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   15: @ce44a5c0  length 800005ea status
800105ea 
May 28 23:15:27 linux06 kernel:   Flags; bus-master 1, dirty 15665(1)
current 15665(1) 
May 28 23:15:27 linux06 kernel:   Transmit list 00000000 vs. ce44a240. 
May 28 23:15:27 linux06 kernel:   0: @ce44a200  length 800005ea status
800105ea 
May 28 23:15:27 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   3: @ce44a2c0  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   4: @ce44a300  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   6: @ce44a380  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   8: @ce44a400  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   9: @ce44a440  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   10: @ce44a480  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   11: @ce44a4c0  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   12: @ce44a500  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   15: @ce44a5c0  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   Flags; bus-master 1, dirty 15669(5)
current 15669(5) 
May 28 23:15:27 linux06 kernel:   Transmit list 00000000 vs. ce44a340. 
May 28 23:15:27 linux06 kernel:   0: @ce44a200  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   3: @ce44a2c0  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   4: @ce44a300  length 800005ea status
800105ea 
May 28 23:15:27 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   6: @ce44a380  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   8: @ce44a400  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   9: @ce44a440  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   10: @ce44a480  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   11: @ce44a4c0  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   12: @ce44a500  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   15: @ce44a5c0  length 800005ea status
000105ea 
May 28 23:15:27 linux06 kernel:   Flags; bus-master 1, dirty 15712(0)
current 15712(0) 
May 28 23:15:27 linux06 kernel:   Transmit list 00000000 vs. ce44a200. 
May 28 23:15:28 linux06 kernel:   0: @ce44a200  length 800005ea status
000105ea 
May 28 23:15:28 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:15:28 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:15:28 linux06 kernel:   3: @ce44a2c0  length 800005ea status
000105ea 
May 28 23:15:28 linux06 kernel:   4: @ce44a300  length 800005ea status
000105ea 
May 28 23:15:28 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:15:28 linux06 kernel:   6: @ce44a380  length 800005ea status
000105ea 
May 28 23:15:28 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:15:28 linux06 kernel:   8: @ce44a400  length 800005ea status
000105ea 
May 28 23:15:28 linux06 kernel:   9: @ce44a440  length 800005ea status
000105ea 
May 28 23:15:28 linux06 kernel:   10: @ce44a480  length 800005ea status
000105ea 
May 28 23:15:28 linux06 kernel:   11: @ce44a4c0  length 800005ea status
000105ea 
May 28 23:15:28 linux06 kernel:   12: @ce44a500  length 800005ea status
000105ea 
May 28 23:15:28 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:15:28 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:15:28 linux06 kernel:   15: @ce44a5c0  length 80000362 status
80010362 
...
May 28 23:17:13 linux06 kernel:   Flags; bus-master 1, dirty 16558(14)
current 16564(4) 
May 28 23:17:13 linux06 kernel:   Transmit list 0e44a240 vs. ce44a580. 
May 28 23:17:13 linux06 kernel:   0: @ce44a200  length 800005ea status
000105ea 
May 28 23:17:13 linux06 kernel:   1: @ce44a240  length 800005ea status
000005ea 
May 28 23:17:13 linux06 kernel:   2: @ce44a280  length 800005ea status
000005ea 
May 28 23:17:13 linux06 kernel:   3: @ce44a2c0  length 800003a6 status
800003a6 
May 28 23:17:13 linux06 kernel:   4: @ce44a300  length 8000008e status
0001008e 
May 28 23:17:13 linux06 kernel:   5: @ce44a340  length 8000008e status
0001008e 
May 28 23:17:13 linux06 kernel:   6: @ce44a380  length 8000008e status
0001008e 
May 28 23:17:13 linux06 kernel:   7: @ce44a3c0  length 8000008e status
0001008e 
May 28 23:17:13 linux06 kernel:   8: @ce44a400  length 8000008e status
0001008e 
May 28 23:17:13 linux06 kernel:   9: @ce44a440  length 800000ae status
000100ae 
May 28 23:17:13 linux06 kernel:   10: @ce44a480  length 8000008e status
0001008e 
May 28 23:17:13 linux06 kernel:   11: @ce44a4c0  length 80000076 status
00010076 
May 28 23:17:13 linux06 kernel:   12: @ce44a500  length 80000096 status
00010096 
May 28 23:17:13 linux06 kernel:   13: @ce44a540  length 800000ae status
000100ae 
May 28 23:17:13 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:17:13 linux06 kernel:   15: @ce44a5c0  length 800005ea status
000105ea 

May 28 23:51:44 linux06 kernel:   Flags; bus-master 1, dirty 17997(13)
current 18000(0) 
May 28 23:51:44 linux06 kernel:   Transmit list 0e44a5c0 vs. ce44a540. 
May 28 23:51:44 linux06 kernel:   0: @ce44a200  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   3: @ce44a2c0  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   4: @ce44a300  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   6: @ce44a380  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   8: @ce44a400  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   9: @ce44a440  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   10: @ce44a480  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   11: @ce44a4c0  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   12: @ce44a500  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   15: @ce44a5c0  length 800005ea status
800005ea 
May 28 23:51:44 linux06 kernel:   Flags; bus-master 1, dirty 18005(5)
current 18005(5) 
May 28 23:51:44 linux06 kernel:   Transmit list 00000000 vs. ce44a340. 
May 28 23:51:44 linux06 kernel:   0: @ce44a200  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   3: @ce44a2c0  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   4: @ce44a300  length 800005ea status
800105ea 
May 28 23:51:44 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   6: @ce44a380  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   8: @ce44a400  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   9: @ce44a440  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   10: @ce44a480  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   11: @ce44a4c0  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   12: @ce44a500  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   15: @ce44a5c0  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   Flags; bus-master 1, dirty 18007(7)
current 18007(7) 
May 28 23:51:44 linux06 kernel:   Transmit list 00000000 vs. ce44a3c0. 
May 28 23:51:44 linux06 kernel:   0: @ce44a200  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   3: @ce44a2c0  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   4: @ce44a300  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   6: @ce44a380  length 800005ea status
800105ea 
May 28 23:51:44 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   8: @ce44a400  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   9: @ce44a440  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   10: @ce44a480  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   11: @ce44a4c0  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   12: @ce44a500  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   15: @ce44a5c0  length 800005ea status
000105ea 
May 28 23:51:44 linux06 kernel:   Flags; bus-master 1, dirty 18057(9)
current 18057(9) 
May 28 23:51:44 linux06 kernel:   Transmit list 00000000 vs. ce44a440. 
May 28 23:51:45 linux06 kernel:   0: @ce44a200  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   3: @ce44a2c0  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   4: @ce44a300  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   6: @ce44a380  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   8: @ce44a400  length 800005ea status
800105ea 
May 28 23:51:45 linux06 kernel:   9: @ce44a440  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   10: @ce44a480  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   11: @ce44a4c0  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   12: @ce44a500  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   15: @ce44a5c0  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   Flags; bus-master 1, dirty 18063(15)
current 18063(15) 
May 28 23:51:45 linux06 kernel:   Transmit list 00000000 vs. ce44a5c0. 
May 28 23:51:45 linux06 kernel:   0: @ce44a200  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   3: @ce44a2c0  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   4: @ce44a300  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   6: @ce44a380  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   8: @ce44a400  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   9: @ce44a440  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   10: @ce44a480  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   11: @ce44a4c0  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   12: @ce44a500  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   14: @ce44a580  length 800005ea status
800105ea 
May 28 23:51:45 linux06 kernel:   15: @ce44a5c0  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   Flags; bus-master 1, dirty 18098(2)
current 18100(4) 
May 28 23:51:45 linux06 kernel:   Transmit list 00000000 vs. ce44a280. 
May 28 23:51:45 linux06 kernel:   0: @ce44a200  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   3: @ce44a2c0  length 800005ea status
800105ea 
May 28 23:51:45 linux06 kernel:   4: @ce44a300  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   6: @ce44a380  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   8: @ce44a400  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   9: @ce44a440  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   10: @ce44a480  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   11: @ce44a4c0  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   12: @ce44a500  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   15: @ce44a5c0  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   Flags; bus-master 1, dirty 18106(10)
current 18106(10) 
May 28 23:51:45 linux06 kernel:   Transmit list 00000000 vs. ce44a480. 
May 28 23:51:45 linux06 kernel:   0: @ce44a200  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   3: @ce44a2c0  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   4: @ce44a300  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   6: @ce44a380  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   8: @ce44a400  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   9: @ce44a440  length 800005ea status
800105ea 
May 28 23:51:45 linux06 kernel:   10: @ce44a480  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   11: @ce44a4c0  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   12: @ce44a500  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   15: @ce44a5c0  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   Flags; bus-master 1, dirty 18107(11)
current 18107(11) 
May 28 23:51:45 linux06 kernel:   Transmit list 00000000 vs. ce44a4c0. 
May 28 23:51:45 linux06 kernel:   0: @ce44a200  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   1: @ce44a240  length 800005ea status
000105ea 
May 28 23:51:45 linux06 kernel:   2: @ce44a280  length 800005ea status
000105ea 
May 28 23:51:46 linux06 kernel:   3: @ce44a2c0  length 800005ea status
000105ea 
May 28 23:51:46 linux06 kernel:   4: @ce44a300  length 800005ea status
000105ea 
May 28 23:51:46 linux06 kernel:   5: @ce44a340  length 800005ea status
000105ea 
May 28 23:51:46 linux06 kernel:   6: @ce44a380  length 800005ea status
000105ea 
May 28 23:51:46 linux06 kernel:   7: @ce44a3c0  length 800005ea status
000105ea 
May 28 23:51:46 linux06 kernel:   8: @ce44a400  length 800005ea status
000105ea 
May 28 23:51:46 linux06 kernel:   9: @ce44a440  length 800005ea status
000105ea 
May 28 23:51:46 linux06 kernel:   10: @ce44a480  length 800005ea status
800105ea 
May 28 23:51:46 linux06 kernel:   11: @ce44a4c0  length 800005ea status
000105ea 
May 28 23:51:46 linux06 kernel:   12: @ce44a500  length 800005ea status
000105ea 
May 28 23:51:46 linux06 kernel:   13: @ce44a540  length 800005ea status
000105ea 
May 28 23:51:46 linux06 kernel:   14: @ce44a580  length 800005ea status
000105ea 
May 28 23:51:46 linux06 kernel:   15: @ce44a5c0  length 800005ea status
000105ea 
...
May 30 10:37:48 linux06 kernel:   Flags; bus-master 1, dirty 107661(13)
current 107661(13) 
May 30 10:37:48 linux06 kernel:   Transmit list 00000000 vs. ce44a540. 
May 30 10:37:48 linux06 kernel:   0: @ce44a200  length 8000037f status
0001037f 
May 30 10:37:48 linux06 kernel:   1: @ce44a240  length 8000004a status
0001004a 
May 30 10:37:48 linux06 kernel:   2: @ce44a280  length 80000042 status
00010042 
May 30 10:37:48 linux06 kernel:   3: @ce44a2c0  length 800003ad status
000103ad 
May 30 10:37:48 linux06 kernel:   4: @ce44a300  length 80000042 status
00010042 
May 30 10:37:48 linux06 kernel:   5: @ce44a340  length 800003b2 status
000103b2 
May 30 10:37:48 linux06 kernel:   6: @ce44a380  length 8000004a status
0001004a 
May 30 10:37:48 linux06 kernel:   7: @ce44a3c0  length 80000042 status
00010042 
May 30 10:37:48 linux06 kernel:   8: @ce44a400  length 8000004a status
0001004a 
May 30 10:37:48 linux06 kernel:   9: @ce44a440  length 80000042 status
00010042 
May 30 10:37:48 linux06 kernel:   10: @ce44a480  length 800003b1 status
000103b1 
May 30 10:37:48 linux06 kernel:   11: @ce44a4c0  length 800003b1 status
000103b1 
May 30 10:37:48 linux06 kernel:   12: @ce44a500  length 800003b1 status
800103b1 
May 30 10:37:48 linux06 kernel:   13: @ce44a540  length 80000042 status
00010042 
May 30 10:37:48 linux06 kernel:   14: @ce44a580  length 80000042 status
00010042 
May 30 10:37:48 linux06 kernel:   15: @ce44a5c0  length 80000042 status
00010042 
