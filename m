Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281815AbRKRBos>; Sat, 17 Nov 2001 20:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281841AbRKRBoh>; Sat, 17 Nov 2001 20:44:37 -0500
Received: from granger.mail.mindspring.net ([207.69.200.148]:24108 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S281840AbRKRBo2>; Sat, 17 Nov 2001 20:44:28 -0500
Message-ID: <3BF7139F.F62CF5D5@mindspring.com>
Date: Sat, 17 Nov 2001 17:49:19 -0800
From: Joe <joeja@mindspring.com>
Reply-To: joeja@mindspring.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.14  cpia driver can't open /dev/video0: No such device
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting this message  "can't open /dev/video0: No such device" in
2.4.14 and I am completely baffeled at this time!

1) /dev/video0 exists   ls -l shows  "crw-rw-rw-    1   root root
81,   0 Nov 17 15:05 /dev/video0"

2) ls /proc/cpia/video0 exists and show lots of info (email me if you
want it)

3) ls /proc/video/dev/video0 also exists and shows:
name            : CPiA Camera
type            : VID_TYPE_CAPTURE
hardware        : 0x18

4) When I start xawtv it gives the message "can't open /dev/video0: No
such device"

lastly it works under redhat's default kernel 2.4.7 and it seems that
the video driver 2.4.14 is 0.74 but the one in redhats kernel is > 1.0

I'm going to try getting the latest driver from their site and see if
that works, anyone else experiencing this or know anything about this?

Joe
