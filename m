Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130335AbRAKRQ2>; Thu, 11 Jan 2001 12:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130230AbRAKRQR>; Thu, 11 Jan 2001 12:16:17 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:18979 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S129842AbRAKRQG>;
	Thu, 11 Jan 2001 12:16:06 -0500
Message-ID: <3A5DEA5D.B783B323@student.ethz.ch>
Date: Thu, 11 Jan 2001 18:16:13 +0100
From: Giacomo Catenazzi <cate@student.ethz.ch>
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en, en-US, en-GB
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Compile error: DRM without AGP in 2.4.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jan 2001 17:16:04.0287 (UTC) FILETIME=[2D8CACF0:01C07BF2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here a valid configuration (no AGP, but all DRM set)
compiling [2.4.0]:

r128_cce.c: In function `r128_cce_init_ring_buffer':
r128_cce.c:339: structure has no member named `agp'
r128_cce.c:333: warning: `ring_start' might be used uninitialized in
          this function
r128_cce.c: In function `r128_cce_packet':
r128_cce.c:1023: warning: unused variable `size'
r128_cce.c:1021: warning: unused variable `buffer'
r128_cce.c:1019: warning: unused variable `dev_priv'


	giacomo


PS: This bug is not on my machine. It is reported via IRC,
so I cannot include to much info...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
