Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263652AbTEEQX4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTEEQWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:22:04 -0400
Received: from franka.aracnet.com ([216.99.193.44]:55226 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263620AbTEEQVF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:21:05 -0400
Date: Mon, 05 May 2003 09:33:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 654] New: Floppy access locks system with endless stream of
 errors
Message-ID: <9950000.1052152383@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=654

           Summary: Floppy access locks system with endless stream of errors
    Kernel Version: 2.5.68-bk11
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: bwindle-kbt@fint.org


Distribution: Debian Testing
Hardware Environment: Dell Optiplex GXa
Problem Description:

Trying to mount a floppy gives an endless stream of:
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 0
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 0

The system is non-responsive to changes to VTs, it can't be pinged, but 
alt+sysrq prints "SysRq: Show State" but never prints anything beyond that
(but  changing LogLevel via Sysrq works).

Ctrl+alt+delete has no effect, numlock won't turn on/off numlock light.

Steps to reproduce:
Insert floppy, try to mount it.


