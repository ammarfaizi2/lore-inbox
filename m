Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263110AbTJJVz1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 17:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbTJJVz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 17:55:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:12013 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263110AbTJJVzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 17:55:18 -0400
Date: Fri, 10 Oct 2003 14:55:17 -0700 (PDT)
From: Judith Lebzelter <judith@osdl.org>
To: <linux-kernel@vger.kernel.org>
Subject: OSDL Iozone results for latest kernels 
In-Reply-To: <20031010191721.GB2862@talus.logic.net>
Message-ID: <Pine.LNX.4.33.0310101432350.2437-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello;

I am publishing Iozone results for the latest 2.6 kernels in a
format meant to easily show IO differences between the kernels
on several filesystems.  The URL is:
     http://developer.osdl.org/judith/iozone_index.html

The tests are all run in the Scalable Test Platform at OSDL,
and the report is updated every few hours.

Example results:
These (below) show that for 128k records on ext2, test7 is consistantly
better than test1, but only better than 2.4.22 for Reader and Fread. (Look
at the Ave %.)  The web based reports have links to the Iozone report
data:
    http://www.osdl.org/archive/judith/tests/iozone/hist.2-CPU.ext2.bigrec.html

Iozone Summary:  2-CPU/ext2
Large Record Size 128k
Writer report
Min %     Max %   Ave % Kernel
  0.00    0.00    0.00  linux-2.6.0-test1
 -1.08    3.28    1.37  linux-2.6.0-test7
  7.49   44.40   16.65  linux-2.4.22
Reader report
Min %     Max %   Ave % Kernel
  0.00    0.00    0.00  linux-2.6.0-test1
  0.50    6.02    3.91  linux-2.6.0-test7
-10.51    2.69    0.20  linux-2.4.22
Random read report
Min %     Max %   Ave % Kernel
  0.00    0.00    0.00  linux-2.6.0-test1
 -9.00    3.22    0.87  linux-2.6.0-test7
 -0.52  128.91   12.95  linux-2.4.22
Random write report
Min %     Max %   Ave % Kernel
  0.00    0.00    0.00  linux-2.6.0-test1
 -0.72    6.08    3.19  linux-2.6.0-test7
  0.50   90.97   10.95  linux-2.4.22
Fwrite report
Min %     Max %   Ave % Kernel
  0.00    0.00    0.00  linux-2.6.0-test1
 -0.68    9.01    3.41  linux-2.6.0-test7
  5.62   37.83   13.84  linux-2.4.22
Fread report
Min %     Max %   Ave % Kernel
  0.00    0.00    0.00  linux-2.6.0-test1
  0.85    6.82    5.01  linux-2.6.0-test7
-13.64    3.91    0.83  linux-2.4.22

Iozone is an IO test. It measures 'operations per second' where
the 'operations' are the various types of reads and writes. These
summaries report the percent difference for each kernel tested
from the chosen baseline kernel(currently linux-2.6.0-test6).
There is also a 'historical' link which compares only the baseline
2.6.0-test kernels.

Go to the link for the results for more kernels.  I hope these are useful.
Please let me know if they are, or if any changes to the reports would
make them more useful.

Thanks;

Judith Lebzelter
OSDL

