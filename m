Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267325AbTGHOBx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 10:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267335AbTGHN7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 09:59:34 -0400
Received: from franka.aracnet.com ([216.99.193.44]:38053 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S267347AbTGHN7B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 09:59:01 -0400
Date: Tue, 08 Jul 2003 07:13:26 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 891] New: kernel boot hangs on line "executing _Sta and_INI methods:...." on nb presario 2154ea
Message-ID: <40700000.1057673606@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=891

           Summary: kernel boot hangs on line "executing _Sta and_INI
                    methods:...." on nb presario 2154ea
    Kernel Version: 2.5.72
            Status: NEW
          Severity: blocking
             Owner: andrew.grover@intel.com
         Submitter: lsabatini1@tin.it


Distribution: www.kernel.org
Hardware Environment: Compaq presario 2154 ea
Software Environment: redhat 9.0
Problem Description: boot hangs at line "executing _STA and_INI methods:.... 
when enabled acpi and disabled apm on notebook.

Steps to reproduce: decompress kernel, make clean, make menuconfig, disable apm 
and enable acpi from processor to thermal zone, make dep,make bzImage, make 
modules, make modules_install, create link and copy to boot, configure lilo or 
grub with generic lines.


