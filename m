Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTFHPou (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 11:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTFHPot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 11:44:49 -0400
Received: from franka.aracnet.com ([216.99.193.44]:61401 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262015AbTFHPos
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 11:44:48 -0400
Date: Sun, 08 Jun 2003 08:58:23 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 790] New: SDET hangs 
Message-ID: <27880000.1055087903@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: SDET hangs
    Kernel Version: 2.5.70-mjb1
            Status: NEW
          Severity: blocking
             Owner: mbligh@aracnet.com
         Submitter: mbligh@aracnet.com


SDET hangs on NUMA-Q fairly constistently. I've now tried it with the feral
driver to eliminate that. ALT sysrq info will be attatched.

------- Additional Comment #1 From Martin J. Bligh  2003-06-08 08:48 -------

Created an attachment (id=400)
alt sysrq info T + M from hang


------- Additional Comment #2 From Martin J. Bligh 2003-06-08 08:50 -------

Things mainly seem to be stuck in do_page_fault or filemap_nopage


------- Additional Comment #3 From Martin J. Bligh 2003-06-08 08:57 -------

Oh, and I should point out that this works fine in 2.5.69-mjb1, but not
2.5.70-mjb1, but it's exactly the same set of patches.
