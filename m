Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUCLTfS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 14:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUCLTfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 14:35:18 -0500
Received: from mtagate7.de.ibm.com ([195.212.29.156]:16116 "EHLO
	mtagate7.de.ibm.com") by vger.kernel.org with ESMTP id S262422AbUCLTfN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 14:35:13 -0500
Date: Fri, 12 Mar 2004 20:35:00 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: s390 patches for 2.6.4.
Message-ID: <20040312193500.GA2757@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
s390 patches for 2.6.4. The zfcp patches (#8-#10) are big - too big for
my taste but I lost the argument with our scsi folks. They would like
to see their log message cleaup upstream. I seperated the log message
cleanup (#9 and #10) from the real bug fixes. If its too big just skip
these two.

Short descriptions:
1) s390 architecture fixes. This one clashes with the remap-file-pages
   fix for s390 I sent yesterday but the conflict is easy to fix.
2) Some more common i/o layer fixes.
3) Fix for the last sclp fix.
4) Network driver fixes.
5) Dasd driver fixes.
6) z/VM monitor stream fixes.
7) Tape driver fixes.
8) The real zfcp bug fixes.
9) zfcp host adapter message cleanup part 1.
10) zfcp host adapter message cleanup part 2.

Patches are against -bk dated 12.03.2004.

blue skies,
  Martin.

