Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKUBa4>; Mon, 20 Nov 2000 20:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129208AbQKUBaq>; Mon, 20 Nov 2000 20:30:46 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:13829 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129091AbQKUBa2>; Mon, 20 Nov 2000 20:30:28 -0500
Message-ID: <3A19C834.48757E1F@timpanogas.org>
Date: Mon, 20 Nov 2000 17:56:20 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NFS 2.4.0-11 noisy messages/NFS rpc.lockd returns error
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



doing a mount <address>:/dir /mount_point generates the following noisy
error messages:

kmem_create: Forcing size word alignment - nfs-fh

also, the rpc.lockd program is reporting an error when invoked from the
System V init startup scripts:

lockd: lockdsvc: invalid argument 

during system initialization with init 2.78.  

The radio-miropcm20.o driver reports 3 unresolved externals (apm_
functions) and fails with depmod errors during init.

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
