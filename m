Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265153AbSJPQpr>; Wed, 16 Oct 2002 12:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265203AbSJPQpr>; Wed, 16 Oct 2002 12:45:47 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:48621 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S265153AbSJPQpp> convert rfc822-to-8bit; Wed, 16 Oct 2002 12:45:45 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.43 s390.
Date: Wed, 16 Oct 2002 18:49:38 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210161845.44635.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
a small update for 2.5.43. 

01: Simplify some Makefiles.
02: Add missing config.help texts, remove help text for ISA/MCA/EISA bus and
    regenerated defconfigs.
03: Bug fix for copy_to_user/copy_from_user. If the copy faults, it is
    possible that the information in the lowcore gets overwritten. The
    new code is completly independent from program check information.
04: Fixes for the 31 bit emulation of sys_recvmsg, sys_setsockopt and
    sys_futex.
05: Correct extern declaration of cpu_possible_map to get the kernel
    compiled with gcc 3.2.
06: Add module license to dasd driver, add XRC support (timestamps that
    are used for mirroring devices) and two bug fixes.

blue skies,
  Martin.


