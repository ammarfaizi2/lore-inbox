Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbUCGKh3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 05:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbUCGKh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 05:37:29 -0500
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:64959 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261804AbUCGKhV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 05:37:21 -0500
Message-ID: <404AFACB.8010405@stillhq.com>
Date: Sun, 07 Mar 2004 21:34:51 +1100
From: Michael Still <mikal@stillhq.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040221)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6 Patch] madocs-008: Fix breakage in SGML documentation for parport
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Heya,

this patch is needed to get any of the SGML documentation to build with 
2.6.4-rc2. Please apply.

Thanks,
Mikal

--

diff -Nur 
linux-2.6.4-rc2-cset-20040306_1807/Documentation/DocBook/parportbook.tmpl 
linux-2.6.4-rc2-cset-20040306_1807-mandocs/Documentation/DocBook/parportbook.tmpl
--- 
linux-2.6.4-rc2-cset-20040306_1807/Documentation/DocBook/parportbook.tmpl 
2004-03-07 11:24:14.000000000 +1100
+++ 
linux-2.6.4-rc2-cset-20040306_1807-mandocs/Documentation/DocBook/parportbook.tmpl 
2004-03-07 17:39:05.000000000 +1100
@@ -2730,7 +2730,7 @@

  </book>
  <!-- Additional function to be documented:
-!Ddrivers/parport/init.c
+--!Ddrivers/parport/init.c (this file doesn't exist any more)
  -->
  <!-- Local Variables: -->
  <!-- sgml-indent-step: 1 -->

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 11                          |    -- Homer Simpson
