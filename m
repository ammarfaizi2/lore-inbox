Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130145AbRB1NKX>; Wed, 28 Feb 2001 08:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130153AbRB1NKD>; Wed, 28 Feb 2001 08:10:03 -0500
Received: from alpham.uni-mb.si ([164.8.1.101]:16910 "EHLO alpham.uni-mb.si")
	by vger.kernel.org with ESMTP id <S130145AbRB1NJ4>;
	Wed, 28 Feb 2001 08:09:56 -0500
Date: Wed, 28 Feb 2001 14:07:30 +0100
From: Igor Mozetic <igor.mozetic@uni-mb.si>
Subject: 2.4.2 + aic7xxx still broken
To: linux-kernel@vger.kernel.org
Message-id: <15004.63506.871707.827656@ravan.camtp.uni-mb.si>
MIME-version: 1.0
X-Mailer: VM 6.90 under Emacs 20.7.2
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still unable to boot any 2.4.x kernel on this box:
Intel C440GX+, on-board Adaptec AIC-7896/7, 2GB RAM.

2.4.2 + stock aic7xxx:
----------------------
...
SCSI host 0 channel 0 reset (pid 0) timed out - trying harder
SCSI bus is being reset for host 0 channel 0
... ad infinitum

2.4.2 + http://people.FreeBSD.org/~gibbs/linux/ aic7xxx-6.1.4-2.4.2-pre4:
-------------------------------------------------------------------------
...
aic7xxx - abort returns 8194
scsi1:0:0:0 Attempting to queue an ABORT message
scsi1:0:0:0 Command already completed
scsi1:0:0:0 Attempting to queue a TARGET RESET message
scsi1:0:0:0 is not an active device
... ad infinitum

2.2.[17,18] stock driver works fine.
I can provide more info if needed. Any help appreciated.

-Igor Mozetic
