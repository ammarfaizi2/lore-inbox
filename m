Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310508AbSCPTI5>; Sat, 16 Mar 2002 14:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310510AbSCPTIs>; Sat, 16 Mar 2002 14:08:48 -0500
Received: from [63.69.218.108] ([63.69.218.108]:14867 "EHLO
	irvexch1.sextantifs.com") by vger.kernel.org with ESMTP
	id <S310508AbSCPTId>; Sat, 16 Mar 2002 14:08:33 -0500
Message-ID: <FA06AA2C99BCD511951200005A994410AD74DF@IRVEXCH1>
From: "Harbold, John" <John.Harbold@Thales-IFS.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Module symbol name mangling, __wake_up vs. __wake_up_sync
Date: Sat, 16 Mar 2002 10:59:15 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good Morning,

	I am making a Linux kernel with three module.  At the end of the
make process, depmod shows an error:

----------------------------------------------------------------------------
---------------------------

  Unresolved symbol in /lib/modules/linux-2.4.2_hhl20/kernel/driver/... .o

     __wake_up_sync

----------------------------------------------------------------------------
---------------------------

	Upon further investigation of the offending module, I found the
symbol, __wake_up, was successfully mangled, but not, __wake_up_sync.

	What is going on here.  The other two modules don't have this
problem.  What is the "magic" needed to solve this problem.


TIA

	John E. Harbold
