Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131711AbQLLT2A>; Tue, 12 Dec 2000 14:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131682AbQLLT1t>; Tue, 12 Dec 2000 14:27:49 -0500
Received: from p3EE070E2.dip.t-dialin.net ([62.224.112.226]:55542 "EHLO
	guanin.joha.home.net") by vger.kernel.org with ESMTP
	id <S131711AbQLLT1i>; Tue, 12 Dec 2000 14:27:38 -0500
From: Dennis Johannﬂen <askerion@joha.ath.cx>
Date: Tue, 12 Dec 2000 20:56:39 +0100
To: linux-kernel@vger.kernel.org
Subject: NFSv3 Bugreport
Message-ID: <20001212205639.A491@thymin.joha.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFSv3-Kernel-Server:
        Debian potato linux-2.2.16                                              
	mount-2.10f

NFSv3-Kernel-Client(-Support)  
	Debian woodylinux-2.4.0-test10
	mount-2.10q


There is a Bootwarning message, when the /etc/init.d/mountnfs.sh script   
performs the command 'mount -a -t nfs':

<-- Error Message -->

call_verify: server accept status: 2
call_verify: server accept status: 2
call_verify: server accept status: 2
RPC: garbage, exit EIO
nfs_get_root: getattr error = 5

<-- End of Error mesasge -->

This message is shown for each NFS-Share I want to mount.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
