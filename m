Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312704AbSDFS33>; Sat, 6 Apr 2002 13:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312711AbSDFS32>; Sat, 6 Apr 2002 13:29:28 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:9996 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S312704AbSDFS32>; Sat, 6 Apr 2002 13:29:28 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: lkml <linux-kernel@vger.kernel.org>
Message-ID: <86256B93.00658E1F.00@smtpnotes.altec.com>
Date: Sat, 6 Apr 2002 12:28:25 -0600
Subject: Linux 2.5.8-pre2 ncpfs unresolved symbols
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ncpfs.o has unresolved symbols lock_kernel() and unlock_kernel() in 2.5.8-pre2.
Adding #include <linux/smp-lock.h> in fs/ncpfs/inode.c gets rid of this error.
I can't test the driver until Monday, though, as I won't have access to a
network with a Novell server before then.


