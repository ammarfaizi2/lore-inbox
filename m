Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265247AbRF0Eea>; Wed, 27 Jun 2001 00:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265248AbRF0EeU>; Wed, 27 Jun 2001 00:34:20 -0400
Received: from m11.boston.juno.com ([64.136.24.74]:51613 "EHLO
	m11.boston.juno.com") by vger.kernel.org with ESMTP
	id <S265247AbRF0EeD>; Wed, 27 Jun 2001 00:34:03 -0400
To: linux-kernel@vger.kernel.org
Date: Wed, 27 Jun 2001 00:32:53 -0400
Subject: driver/sound/soundcard.c lock_kernel()/unlock_kernel()
Message-ID: <20010627.003255.-205571.0.fdavis112@juno.com>
X-Mailer: Juno 5.0.15
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Juno-Line-Breaks: 0,2,7-10
From: Frank Davis <fdavis112@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
      I've been looking through the sound drivers in the 2.4.5-ac series
.  
drivers/sound/soundcard.c has a few lock_kernel()/unlock_kernel() calls,
esp. in the read() and write() functions. Could these calls be easily
replaced with semaphores or spinlock calls? I vaguely remember emails on
lkml a while ago regarding the removal of lock_kernel()/unlock_kernel(),
but I'm don't recall what the replacement was (if any).
Regards,
Frank

btw, Sorry in advance if the mailer causes probelms.
