Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263780AbRFWMIx>; Sat, 23 Jun 2001 08:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263930AbRFWMIn>; Sat, 23 Jun 2001 08:08:43 -0400
Received: from juicer02.bigpond.com ([139.134.6.78]:44274 "EHLO
	mailin5.bigpond.com") by vger.kernel.org with ESMTP
	id <S263780AbRFWMIX>; Sat, 23 Jun 2001 08:08:23 -0400
Message-ID: <3B3486C7.7A39478@bigpond.com>
Date: Sat, 23 Jun 2001 22:08:39 +1000
From: Allan Duncan <allan.d@bigpond.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac17 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Shared memory quantity not being reflected by /proc/meminfo
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the 2.4.x advent of shm as tmpfs or thereabouts,
/proc/meminfo shows shared memory as 0.  It is in
reality not zero, and is being allocated, and shows
up in /proc/sysvipc/shm and /proc/sys/kernel/shmall
etc..
Neither 2.4.6-pre5 nor 2.4.5-ac17 have the correct
display.
