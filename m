Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129307AbRBTRK7>; Tue, 20 Feb 2001 12:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbRBTRKt>; Tue, 20 Feb 2001 12:10:49 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:51466 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S129307AbRBTRKe>;
	Tue, 20 Feb 2001 12:10:34 -0500
Envelope-To: <linux-kernel@vger.kernel.org>
Date: Tue, 20 Feb 2001 17:03:23 +0000 (GMT)
From: James Stevenson <mistral@stev.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: /dev/netlink/tap0
Message-ID: <Pine.LNX.4.21.0102201646270.6033-100000@cyrix.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

if i have a valid tap0 device i should be able to
read write to /dev/netlink/tap0 but for some reson
only as root should it be like this ?

eg i would think that is the file permissions are like
crw-rw-rw-  /dev/netlink/tap0

anyone should be able to open it.
is it meant to be like this if it is it seems very misleading
from what i can tell it calls
ethertap_open then it calls
etlink_kernel_create then it calls
sock_create where i think it is failing because it does not
have CAP_NET_RAW


thanks
	James

-- 
---------------------------------------------
Check Out: http://stev.org
E-Mail: mistral@stev.org
  4:40pm  up 19 days, 25 min,  6 users,  load average: 0.08, 0.12, 0.42

