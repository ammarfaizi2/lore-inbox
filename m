Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265649AbSLIQLt>; Mon, 9 Dec 2002 11:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265675AbSLIQLt>; Mon, 9 Dec 2002 11:11:49 -0500
Received: from [195.212.29.5] ([195.212.29.5]:46564 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S265649AbSLIQLt>; Mon, 9 Dec 2002 11:11:49 -0500
Message-Id: <200212091618.gB9GITk8128954@d06relay02.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: Peter Oberparleiter <oberpapr@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: Re:Code coverage
Date: Mon, 9 Dec 2002 17:18:18 +0100
X-Mailer: KMail [version 1.3.1]
Cc: santhoshk@nestec.net
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Can I take code coverage of a linux driver?
There is the GCC GNU coverage facility (GCOV) that may be exploited for this 
purpose. To use it with the kernel, get and apply the GCOV kernel patch 
(gcov-kernel.tar.gz) which may be found in the "files" section at:

  http://sourceforge.net/projects/lse

There's also an extension for the text-only output of GCOV available which 
builds on the mentioned kernel patch and provides an easy-to-use interface 
including HTML output, bar-graphs, browsable overview list, etc. It's called 
LCOV and can be found at:

  http://ltp.sourceforge.net/lcov.php


Regards,
  Peter Oberparleiter
