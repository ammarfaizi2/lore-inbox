Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264169AbRFMB4c>; Tue, 12 Jun 2001 21:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264181AbRFMB4W>; Tue, 12 Jun 2001 21:56:22 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:38180
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S264169AbRFMB4E>; Tue, 12 Jun 2001 21:56:04 -0400
Date: Tue, 12 Jun 2001 18:56:03 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: double entries in /proc/dri?
Message-ID: <20010612185603.A2031@work.bitmover.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is cute:

$ ls -li /proc 
...
   4106 -r--r--r--    1 root     root            0 Jun 12 18:53 dma
   4347 dr-xr-xr-x    3 root     root            0 Jun 12 18:53 dri
   4347 dr-xr-xr-x    3 root     root            0 Jun 12 18:53 dri
   4121 dr-xr-xr-x    2 root     root            0 Jun 12 18:53 driver
...

$ uname -a
Linux work.bitmover.com 2.4.5 #1 Mon May 28 10:54:32 PDT 2001 i686 unknown

Repeatable.  If other users of 2.4.5 do NOT see this, please let me know.

--lm
