Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVBAKWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVBAKWF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 05:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVBAKWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 05:22:05 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:19623 "EHLO
	webhosting.rdsbv.ro") by vger.kernel.org with ESMTP id S261960AbVBAKV7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 05:21:59 -0500
Date: Tue, 1 Feb 2005 12:21:57 +0200 (EET)
From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
X-X-Sender: util@webhosting.rdsbv.ro
To: linux-kernel@vger.kernel.org
cc: linux-ide@vger.kernel.org
Subject: Strange vmstat output. 2.6.10 Scheduler?
Message-ID: <Pine.LNX.4.62.0502011217320.26221@webhosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have a weird problem with a server. I use deadline.
The output of vmstat is:
  1  1  12312   6064   7580 815432    0    0  5332   456 1263  3119 22  5  0 73
  0  1  12312   5280   7584 816240    0    0  6204   620 1307  1530 15  4  0 81
  0  1  12312   6096   7528 815088    0    0  7604  8732 1256  1398  5  8  0 87
  0  1  12312   6048   7528 815144    0    0     8     8 1243  1440 14  2  0 84
  0  1  12312   6048   7528 815168    0    0     0     0 1261  1287  8  2  0 90
  0  2  12312   6040   7584 815184    0    0     0     0 1258  1197  7  2  0 91
  0  2  12312   6024   7584 815208    0    0     0     0 1265  1309  6  5  0 89
  0  2  12312   6024   7584 815208    0    0     0   136 1253   365  2  2  0 96
  0  2  12312   5984   7584 815208    0    0     0     0 1268   413  2  1  0 97
  0  2  12312   6052   7584 815208    0    0     0     0 1270   375  2  1  0 97
  1  0  12312   6164   7584 815156    0    0  6188   288 1270  4314 23  5  0 72
  0  1  12312   5684   7536 815592    0    0  4128  8656 1270  1316 14  3  0 83
  0  1  12312   5684   7536 815608    0    0     0     0 1258  1251  8  3  0 89
  0  1  12312   5552   7536 815628    0    0     0     0 1258  1327  8  2  0 90
  0  1  12312   5552   7536 815644    0    0     0     0 1264  1127  7  2  0 91
  0  1  12312   5552   7536 815668    0    0     0     2 1258  1225  8  3  0 89
  0  3  12312   5248   7588 816108    0    0  4340   585 1249  1316  7  3  0 90
  0  2  12312   5612   7584 815680    0    0  3092   188 1254   411  3  1  0 96
  0  2  12312   5564   7584 815676    0    0     0     0 1261   259  2  2  0 96
  0  2  12312   5564   7584 815676    0    0     0     0 1254   348  2  1  0 97

It seems strange because iowait is at 90% but nothing is trasnfered 
to/from disk. Why is that?

I run postgresql on this server and I'm not satistied by it's speed.

Single Pentium IV, IDE disk.

What can be the problem?

Thank you very much!
---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/
