Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269180AbRGaF2j>; Tue, 31 Jul 2001 01:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269176AbRGaF2a>; Tue, 31 Jul 2001 01:28:30 -0400
Received: from tomts14.bellnexxia.net ([209.226.175.35]:64749 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S269179AbRGaF2S>; Tue, 31 Jul 2001 01:28:18 -0400
Message-ID: <3B6641F8.7DE33415@yahoo.co.uk>
Date: Tue, 31 Jul 2001 01:28:24 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG REPORT] serial driver fails to delete proc entry on module unload
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Here's what happens when you load and unload the 
2.4.7-ac3 serial driver five times:          // Thomas Hood

root@thanatos:/proc/tty/driver# ll
total 0
dr-xr-xr-x    2 root     root            0 Jul 31 01:22 ./
dr-xr-xr-x    4 root     root            0 Jul 31 01:22 ../
-r--r--r--    1 root     root            0 Jul 31 01:27 serial
-r--r--r--    1 root     root            0 Jul 31 01:27 serial
-r--r--r--    1 root     root            0 Jul 31 01:27 serial
-r--r--r--    1 root     root            0 Jul 31 01:27 serial
-r--r--r--    1 root     root            0 Jul 31 01:27 serial
