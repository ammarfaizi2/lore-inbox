Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263660AbTEEQ1A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbTEEQ02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:26:28 -0400
Received: from franka.aracnet.com ([216.99.193.44]:56772 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263660AbTEEQ0F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:26:05 -0400
Date: Mon, 05 May 2003 09:38:02 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 657] New: The HTB utility is not working properly using 2.5.68
 kernel
Message-ID: <10740000.1052152682@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=657

           Summary: The HTB utility is not working properly using 2.5.68
                    kernel
    Kernel Version: 2.5.68
            Status: NEW
          Severity: normal
             Owner: acme@conectiva.com.br
         Submitter: yaronb@warpera.com
                CC: yaronb@warpera.com


Distribution:
Hardware Environment: Intl Pentium-4
Software Environment: Linux kernel 2.5.68
Problem Description: I tested the HTB utility with 2.5.68 kernel, and it
looks  like it doesn't work properly. It works well with 2.3 and 2.4.20
kernels. 

Steps to reproduce:

 Build and install 2.5.68 kernel.
 Create an HTB qdisc, a class with max rate and ceil of 30000Kbit/s.
 Create a filter attached to that class.
 I pushed up to 70000Kbit/s through the filtered interface using the
filterd IP  address, but the Rate limit didn't have any effect. So the
output was  70000Kbit/s. It looks like the HTB functionality is broken.

   Let me know if you need more info.
     
         Yaron

