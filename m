Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263270AbVGAHrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbVGAHrK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 03:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVGAHrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 03:47:10 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:6568 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263268AbVGAHqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 03:46:46 -0400
Date: Fri, 1 Jul 2005 13:26:00 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: aio-stress throughput regressions from 2.6.11 to 2.6.12
Message-ID: <20050701075600.GC4625@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Has anyone else noticed major throughput regressions for random
reads/writes with aio-stress in 2.6.12 ?
Or have there been any other FS/IO regressions lately ?

On one test system I see a degradation from around 17+ MB/s to 11MB/s
for random O_DIRECT AIO (aio-stress -o3 testext3/rwfile5) from 2.6.11
to 2.6.12. It doesn't seem filesystem specific. Not good :(

BTW, Chris/Ben, it doesn't look like the changes to aio.c have had an impact
(I copied those back to my 2.6.11 tree and tried the runs with no effect)
So it is something else ...

Ideas/thoughts/observations ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

