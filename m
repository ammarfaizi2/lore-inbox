Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131606AbRDCMHu>; Tue, 3 Apr 2001 08:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131629AbRDCMHl>; Tue, 3 Apr 2001 08:07:41 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5893 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131606AbRDCMH2>; Tue, 3 Apr 2001 08:07:28 -0400
Subject: Re: 2.4.3 SMP: nfs stale handle, fb dualhead hardlock, G400/450 misnaming
To: elmer@linking.ee (Elmer Joandi)
Date: Tue, 3 Apr 2001 13:07:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0104031152270.21867-100000@ns.linking.ee> from "Elmer Joandi" at Apr 03, 2001 12:03:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kPbH-0007ts-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. stale NFS file handle
> 	2.4.2-ac28 serving nfs3 from reiserfs
> 	2.4.3 being nfs3 client,

You need additional patches for NFS serving from Reiserfs

> 3. seems that I have G450 and linux shows it as G400. 
> 	bash-2.04$ /sbin/lspci:
> 	01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82)	

The G450 and G400 use the same PCI identity, and different subids. So that
is expected behaviour rather than a bug


