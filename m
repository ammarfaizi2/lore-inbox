Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130281AbRADWYQ>; Thu, 4 Jan 2001 17:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129830AbRADWYH>; Thu, 4 Jan 2001 17:24:07 -0500
Received: from madli.ut.ee ([193.40.5.124]:37842 "EHLO madli.ut.ee")
	by vger.kernel.org with ESMTP id <S129183AbRADWXu>;
	Thu, 4 Jan 2001 17:23:50 -0500
Date: Fri, 5 Jan 2001 00:23:48 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: prerelease-ac6 compile problem in serial.c
Message-ID: <Pine.GSO.4.21.0101050022210.9014-100000@madli.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.0-prerelease-ac6 doesn't compile serial on x86 with pnp enabled:

serial.c: In function `probe_serial_pnp':
serial.c:5187: structure has no member named `device'
serial.c:5192: structure has no member named `device'

---
Meelis Roos <mroos@linux.ee>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
