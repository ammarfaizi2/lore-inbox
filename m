Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270365AbTGMTgL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 15:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270366AbTGMTgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 15:36:11 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:8832 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S270365AbTGMTgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 15:36:10 -0400
From: Nicolas <linux@1g6.biz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: memory shown with free
Date: Sun, 13 Jul 2003 21:50:56 +0200
User-Agent: KMail/1.5
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307132150.56661.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Can somebody explain me this numbers ?
The cache number seems false isn't it ?

Nicolas.

(kernel 2.5.75)
[root@hal9003 npa]# free
             total       used       free     shared    buffers     cached
Mem:       1034372     336472     697900          0      27272      98820
-/+ buffers/cache:     210380     823992
Swap:            0          0          0
[root@hal9003 npa]# find / > /dev/null
[root@hal9003 npa]# free
             total       used       free     shared    buffers     cached
Mem:       1034372     909520     124852          0      84464      98820
-/+ buffers/cache:     726236     308136
Swap:            0          0          0

