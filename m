Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263669AbTEEQ2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbTEEQ1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:27:14 -0400
Received: from franka.aracnet.com ([216.99.193.44]:23237 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263664AbTEEQ02
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:26:28 -0400
Date: Mon, 05 May 2003 09:38:26 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 646] New: modprobe i810/i830 fails with "Cannot allocate
 memory" 
Message-ID: <10830000.1052152706@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=646

           Summary: modprobe i810/i830 fails with "Cannot allocate memory"
    Kernel Version: 2.5.68
            Status: NEW
          Severity: blocking
             Owner: bugme-janitors@lists.osdl.org
         Submitter: s.rivoir@gts.it


Distribution: Debian unstable 
Hardware Environment: HP Omnibook XE3l 
Software Environment: 
Problem Description: 
Modules i810/i830 cannot be inserted (agpgart is already inserted) because
modprobe fails  with "Cannot allocate memory" 
 
Steps to reproduce: 
# modprope agpgart 
# modprobe i830


