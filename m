Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265673AbRF1Mwy>; Thu, 28 Jun 2001 08:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265678AbRF1Mwo>; Thu, 28 Jun 2001 08:52:44 -0400
Received: from shami.gointernet.co.uk ([212.111.50.88]:45576 "EHLO
	shami.gointernet.co.uk") by vger.kernel.org with ESMTP
	id <S265673AbRF1Mw0>; Thu, 28 Jun 2001 08:52:26 -0400
Message-ID: <3B3B28A6.A2457959@gointernet.co.uk>
Date: Thu, 28 Jun 2001 13:52:54 +0100
From: Eugenio Mastroviti <eugeniom@gointernet.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hack Central <linux-kernel@vger.kernel.org>
CC: Go Internet Support <support@gointernet.co.uk>
Subject: __alloc_pages: 1-order allocation failed
Content-Type: multipart/mixed;
 boundary="------------911D442B933A7A3B6647DE18"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------911D442B933A7A3B6647DE18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This is possibly not the best place to post this message, but if anybody
could help I'd be very grateful...

Twice at about the same time one of our server, running kernel 2.4.4,
has died. Attached is an excerpt from syslog - the actual list of
messages is 5 or 6 times longer, all with the same timestamp - after
this the machine froze until it was rebooted, about an hour later.

The server is a dual-CPU Dell 2450 with 1.5GB RAM, 1.5GB swap, Megaraid
controller, running application server software

Another identical server in the same subnet, running the same kind of
software with kernel 2.2.16 without any modification, is running fine in
spite of the bigger load on it (more threads, larger memory usage)

Eugenio Mastroviti

Systems Administrator

Go Internet Ltd
--------------911D442B933A7A3B6647DE18
Content-Type: text/plain; charset=us-ascii;
 name="syslog_part"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syslog_part"

Jun 27 23:57:36 primitivo kernel: __alloc_pages: 1-order allocation failed.
Jun 27 23:57:36 primitivo last message repeated 3716 times
Jun 27 23:57:36 primitivo kernel: __alloc_pages: 1-order allocation failed.
Jun 27 23:57:36 primitivo last message repeated 3243 times
Jun 27 23:57:36 primitivo kernel: NET: 9 messages suppressed.
Jun 27 23:57:36 primitivo kernel: __alloc_pages: 1-order allocation failed.
Jun 27 23:57:36 primitivo last message repeated 40 times
Jun 27 23:57:36 primitivo kernel: NET: 11 messages suppressed.
Jun 27 23:57:36 primitivo kernel: __alloc_pages: 1-order allocation failed.
Jun 27 23:57:36 primitivo last message repeated 75 times
Jun 27 23:57:36 primitivo kernel: NET: 13 messages suppressed.
Jun 27 23:57:36 primitivo kernel: __alloc_pages: 1-order allocation failed.
Jun 27 23:57:36 primitivo last message repeated 55 times
Jun 27 23:57:36 primitivo kernel: NET: 9 messages suppressed.
Jun 27 23:57:36 primitivo kernel: __alloc_pages: 1-order allocation failed.
Jun 27 23:57:36 primitivo last message repeated 41 times
Jun 27 23:57:36 primitivo kernel: NET: 12 messages suppressed.
Jun 27 23:57:36 primitivo kernel: __alloc_pages: 1-order allocation failed.
Jun 27 23:57:36 primitivo last message repeated 51 times
Jun 27 23:57:36 primitivo kernel: NET: 8 messages suppressed.
Jun 27 23:57:36 primitivo kernel: __alloc_pages: 1-order allocation failed.
Jun 27 23:57:36 primitivo last message repeated 56 times
Jun 27 23:57:36 primitivo kernel: NET: 7 messages suppressed.
Jun 27 23:57:36 primitivo kernel: __alloc_pages: 1-order allocation failed.
Jun 27 23:57:36 primitivo last message repeated 40 times
Jun 27 23:57:36 primitivo kernel: NET: 13 messages suppressed.
Jun 27 23:57:36 primitivo kernel: __alloc_pages: 1-order allocation failed.
Jun 27 23:57:36 primitivo last message repeated 63 times
Jun 27 23:57:36 primitivo kernel: NET: 11 messages suppressed.
Jun 27 23:57:36 primitivo kernel: __alloc_pages: 1-order allocation failed.
Jun 27 23:57:36 primitivo last message repeated 61 times
Jun 27 23:57:36 primitivo kernel: NET: 11 messages suppressed.
Jun 27 23:57:36 primitivo kernel: __alloc_pages: 1-order allocation failed.
Jun 27 23:57:36 primitivo last message repeated 69 times
Jun 27 23:57:36 primitivo kernel: NET: 8 messages suppressed.
Jun 27 23:57:36 primitivo kernel: __alloc_pages: 1-order allocation failed.
Jun 27 23:57:36 primitivo last message repeated 66 times
Jun 27 23:57:36 primitivo kernel: NET: 8 messages suppressed.
Jun 27 23:57:36 primitivo kernel: __alloc_pages: 1-order allocation failed.
Jun 27 23:57:36 primitivo last message repeated 56 times
Jun 27 23:57:36 primitivo kernel: NET: 13 messages suppressed.
Jun 27 23:57:36 primitivo kernel: __alloc_pages: 1-order allocation failed.
Jun 27 23:57:36 primitivo last message repeated 63 times
Jun 27 23:57:36 primitivo kernel: NET: 5 messages suppressed.
Jun 27 23:57:36 primitivo kernel: __alloc_pages: 1-order allocation failed.
Jun 27 23:57:36 primitivo last message repeated 87 times
Jun 27 23:57:36 primitivo kernel: NET: 14 messages suppressed.
Jun 27 23:57:36 primitivo kernel: __alloc_pages: 1-order allocation failed.
Jun 27 23:57:36 primitivo last message repeated 30 times
Jun 27 23:57:36 primitivo kernel: NET: 10 messages suppressed.
Jun 27 23:57:36 primitivo kernel: __alloc_pages: 1-order allocation failed.

--------------911D442B933A7A3B6647DE18--

