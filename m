Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVCCBK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVCCBK1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 20:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVCCBGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:06:09 -0500
Received: from smtpout.mac.com ([17.250.248.97]:13044 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261351AbVCCBEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:04:05 -0500
Mime-Version: 1.0 (Apple Message framework v619)
Content-Transfer-Encoding: 7bit
Message-Id: <214EB158-8B80-11D9-858B-000393ACC76E@mac.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: lkml Mailing List <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: POLLWRNORM vs POLLOUT
Date: Wed, 2 Mar 2005 20:04:01 -0500
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was attempting to merge the asm-*/poll.h files, which I noticed were 
virtually
identical, into linux/poll.h when I noticed that several platforms, 
specifically
frv, h8300, m68k, m68knommu, mips, sparc, sparc64, and v850, all define 
the
POLLWRNORM constant to POLLOUT, while the rest define POLLWRNORM to its 
own value,
256.  Is there any reason for this difference, or is it a hack in need 
of fixing?

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------

