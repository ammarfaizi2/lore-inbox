Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266473AbTB0U6T>; Thu, 27 Feb 2003 15:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266805AbTB0U6T>; Thu, 27 Feb 2003 15:58:19 -0500
Received: from [24.27.43.2] ([24.27.43.2]:18 "EHLO snafu.haywired.net")
	by vger.kernel.org with ESMTP id <S266473AbTB0U6S>;
	Thu, 27 Feb 2003 15:58:18 -0500
Date: Thu, 27 Feb 2003 14:48:16 -0600 (CST)
From: Paul B Schroeder <paulsch@haywired.net>
To: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
cc: <girouard@us.ibm.com>
Subject: [PATCH][2.5] mwave updates
Message-ID: <Pine.LNX.4.33.0302271430390.18104-100000@snafu.haywired.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch can be found here...

http://www.haywired.net/~paulsch/patches/mwave-2.5.63.patch

It is obviously against 2.5.63 and applies cleanly..  Linus, please apply..

Thanks...Paul...


Changes include..
* proc support dropped in favor of sysfs
* other miscellaneous fixes and cleanups

* smapi.c changes and fixes from Wes Schreiner <wes@infosink.com>
1. When IR port is disabled skip io address and irq checks.
2. Actually compiles with gcc 2.95.4 when MWAVE_FUTZ_WITH_OTHER_DEVICES is
defined.
3. Makes error printks a little more informative.



-- 

Paul B Schroeder
paulsch@haywired.net




