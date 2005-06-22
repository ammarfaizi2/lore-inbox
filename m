Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVFVV1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVFVV1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 17:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVFVVYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 17:24:11 -0400
Received: from fmr22.intel.com ([143.183.121.14]:59776 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262539AbVFVVP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:15:56 -0400
Message-Id: <200506222115.j5MLFtg10364@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Subject: Update: Industry db benchmark result
Date: Wed, 22 Jun 2005 14:15:56 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcV3b5QfzDf46FAZRlOIaveIcnSFgA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's been awhile since last time I reported Linux kernel performance
for an industry standard transaction processing database benchmark. It's
time to report the data again to keep everyone informed.  Here is the
latest result that we measured (4P 1.6GHz ia64, 9M L3 cache, 64GB memory,
480 15K-RPM disks).

2.4.21-4.EL	baseline
2.6.9		- 6.00%
2.6.11	-13.00%
2.6.12-rc3	-13.54%
2.6.12-rc4	-13.05%
2.6.12-rc5	-12.86%
2.6.12-rc6	-12.66%

It's been hovering around -13%.  I will take a measurement of 2.6.12, though
I don't expect it to deviate too far from 2.6.12-rc6.  There are 718 patches
committed since 2.6.12 as of 6/22 14:09 PDT, so I'm going to take a snapshot
today or tomorrow and queue it up for benchmark measurement.  I will probably
take all the scheduler patches currently in -mm and give that a whirl as well.

- Ken

