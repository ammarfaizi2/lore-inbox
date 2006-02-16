Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWBPWZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWBPWZb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 17:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWBPWZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 17:25:31 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:43156 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750736AbWBPWZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 17:25:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SGmSggeSKACba/LrIVTt1OQWa4cTIlsDX+yK3j83Ul9Ow+CIY4R68ChijWHoao7dCI4xhuHNeNdCEwqcemGCRoiyjzqhyUyrRyrTpPtoXSyxsPJgx48uRI6+YtiXxtmlaQq1u/LAXtsG8mXsYqmDRyeuBGvEwpHSQcU4ftRSNDk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][TRIVIAL] Documentation: Fix typo in cputopology.txt
Date: Thu, 16 Feb 2006 23:25:44 +0100
User-Agent: KMail/1.9.1
Cc: Trivial Patch Monkey <trivial@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602162325.44511.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a small typo in Documentation/cputopology.txt

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/cputopology.txt |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16-rc3-git7/Documentation/cputopology.txt~	2006-02-16 21:11:11.000000000 +0100
+++ linux-2.6.16-rc3-git7/Documentation/cputopology.txt	2006-02-16 21:11:12.000000000 +0100
@@ -12,7 +12,7 @@
 represent the thread siblings to cpu X in the same physical package;
 
 To implement it in an architecture-neutral way, a new source file,
-driver/base/topology.c, is to export the 5 attributes.
+drivers/base/topology.c, is to export the 5 attributes.
 
 If one architecture wants to support this feature, it just needs to
 implement 4 defines, typically in file include/asm-XXX/topology.h.

