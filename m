Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbVAVQzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVAVQzQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 11:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVAVQzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 11:55:16 -0500
Received: from jade.aracnet.com ([216.99.193.136]:211 "EHLO jade.spiritone.com")
	by vger.kernel.org with ESMTP id S262578AbVAVQzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 11:55:10 -0500
Date: Sat, 22 Jan 2005 08:56:25 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 4081] New: OpenOffice crashes while starting due to a threading error
Message-ID: <217740000.1106412985@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please contact bug submitter for more info, not myself.

---------------------------------------------

http://bugme.osdl.org/show_bug.cgi?id=4081

           Summary: OpenOffice crashes while starting due to a threading
                    error
    Kernel Version: 2.6.11-rc2
            Status: NEW
          Severity: blocking
             Owner: process_other@kernel-bugs.osdl.org
         Submitter: diego@pemas.net


Distribution: Debian
Hardware Environment: Pentum III 733 MHz
Software Environment: Debian Sid
Problem Description:
While starting open Office crashes, it did not happend on 2.6.10, but happend on
2.6.11. rc1 and rc2. The only thing that has changed is the kernel. If i go back
to 2.6.10 OpenOffice starts just fine.

gdb shows that it crashes during this call:
thread_get_info_callback: cannot get thread info: generic error

the logs kern.log and messages don't show anything related to this crash.

Steps to reproduce:


