Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270681AbTHAUPP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 16:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270863AbTHAUPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 16:15:15 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:3487 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270681AbTHAUPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 16:15:10 -0400
Date: Fri, 01 Aug 2003 13:18:51 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1029] New: LTP ustat tests break in 2.6.0-test2-mm1
Message-ID: <405500000.1059769131@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1029

           Summary: LTP ustat tests break in 2.6.0-test2-mm1
    Kernel Version: 2.6.0-test2-mm1 and -mm2
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: plars@austin.ibm.com


Distribution: Debian Woody
Hardware Environment: 4-way PIII 700, 4GB ram
Software Environment: 
LTP-20030710
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      2.4.21
e2fsprogs              1.34-WIP
PPP                    2.4.1
nfs-utils              1.0.3
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0

Problem Description: As of 2.6.0-test2-mm1, the ustat01 and ustat02 tests from
LTP return FAIL, but they do not fail in 2.6.0-test2 unpatched.  I'm guessing
this is related to the 64bit dev_t patches?  Is this something that glibc will
have to fix or is it ok to work around it in sys_ustat?

Steps to reproduce:
run ustat01 or ustat02 from LTP


