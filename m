Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVCNAVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVCNAVX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 19:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVCNAVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 19:21:23 -0500
Received: from smtpout.mac.com ([17.250.248.88]:8133 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261596AbVCNAVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 19:21:19 -0500
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bbcd3873d9324ce185dc9eaf146ef741@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Sparc Linux Mailing List <sparclinux@vger.kernel.org>,
       William Lee Irwin <wli@holomorphy.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: [BUG?] Signedness of __kernel_nlink_t on Sparc?
Date: Sun, 13 Mar 2005 19:21:09 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In include/asm-sparc/types.h, __kernel_nlink_t is signed, whereas on 
all the
other architectures it is unsigned.  Is this intentional, or a bug?

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------

