Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbTJJQ3T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTJJQ3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:29:18 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:58258 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263009AbTJJQ2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:28:50 -0400
Date: Fri, 10 Oct 2003 08:37:24 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: freelsjd@ornl.gov
Subject: [Bug 1342] New: Samba breaks in test6 kernel
Message-ID: <207250000.1065800244@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Samba breaks in test6 kernel
    Kernel Version: 2.6.0test7
            Status: NEW
          Severity: normal
             Owner: acme@conectiva.com.br
         Submitter: freelsjd@ornl.gov


Distribution: Debian/Sid
Hardware Environment: dual Xeon 2.4 Ghz
Software Environment: Samba 3.0.0
Problem Description:

In going from 2.6.0test6 to 2.6.0test7, the ability to "Map a network drive"
from Windows to this machine failed.  I have confirmed in going back to test6, 
the problem went away.  I have also confirmed that older versions of Samba had 
the same problem.  I have narrowed it down to the test7 kernel.

Steps to reproduce:

Have a Debian/Sid system with current Samba installed.  Upgrade from test6 to 
test7, and the problem occurs.

