Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268941AbRHLDxd>; Sat, 11 Aug 2001 23:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268949AbRHLDxX>; Sat, 11 Aug 2001 23:53:23 -0400
Received: from s2.org ([195.197.64.39]:45063 "EHLO kalahari.s2.org")
	by vger.kernel.org with ESMTP id <S268941AbRHLDxI>;
	Sat, 11 Aug 2001 23:53:08 -0400
To: linux-kernel@vger.kernel.org
Subject: "scsi0:0:6:0: Attempting to queue an ABORT message" and friends hang
From: Jarno Paananen <jpaana@s2.org>
Date: 12 Aug 2001 06:53:19 +0300
Message-ID: <m3d762c4sw.fsf@kalahari.s2.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I've lately come across these messages a bit too many times:

scsi0:0:6:0: Attempting to queue an ABORT message
scsi0:0:6:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi0:0:6:0: Attempting to queue an ABORT message
scsi0:0:6:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194

[repeat ad infinitum]

and then all disk activity hangs. Is this a bug in the driver or a
symptom from failing disks/cable or something? It happens on both
my disks (sometimes the 0:6:0 is 0:5:0) so I hope it isn't the
disks. I'm running 2.4.8-ac1 now, but it has come up every now and
then since 2.4.6 kernels at least.

// Jarno
