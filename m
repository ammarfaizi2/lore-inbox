Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264429AbUEMTNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbUEMTNm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbUEMTNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:13:42 -0400
Received: from mtagate7.de.ibm.com ([195.212.29.156]:39901 "EHLO
	mtagate7.de.ibm.com") by vger.kernel.org with ESMTP id S264429AbUEMTMx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:12:53 -0400
Date: Thu, 13 May 2004 21:12:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: s390 patches for 2.6.6 / 2.6.6-mm2.
Message-ID: <20040513191247.GA2916@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
the bug fixes for s390 are heaping up again. 6 patches this time, the
biggest is the network driver patch. Business as usual...

1) s390 core changes.
2) Common i/o layer fixes.
3) dasd driver fixes.
4) 3270 console fixes.
5) zfcp host adapter fixes.
6) network driver fixes.

Patches apply against BitKeeper and 2.6.6-mm2 (#1 with hunks but it
works).  By the way I'm having trouble with the scheduler changes in
cset 1.1608.1.32 "balance-on-clone". I was able to track it down
to find_idlest_cpu, it returns 3 on a system with only 1 cpu ?!?
I still have to figure out why this happens.

blue skies,
  Martin.

