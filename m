Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbVCSQTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbVCSQTF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 11:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbVCSQTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 11:19:05 -0500
Received: from jade.aracnet.com ([216.99.193.136]:6865 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S262584AbVCSQTC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 11:19:02 -0500
Date: Sat, 19 Mar 2005 08:18:57 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Scheduling changes in -mm tree
Message-ID: <505920000.1111249137@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think these are doing much for performance. Or at least 
*something* in your tree isn't ...

Kernbench: 
                                     Elapsed    System      User       CPU
 elm3b67      2.6.11                   50.24    146.60   1117.61   2516.67
 elm3b67      2.6.11-mm1               52.27    141.14   1099.91   2374.33
 elm3b67      2.6.11-mm2               51.88    142.41   1104.85   2403.67
 elm3b67      2.6.11-mm4               51.23    145.04   1100.70   2431.00

(elm3b67 is a 16x x440 ia32 NUMA system + HT)

Is there an easy way to just test those sched changes alone?

M.

