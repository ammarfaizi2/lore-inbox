Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTDLVcv (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 17:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTDLVcv (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 17:32:51 -0400
Received: from franka.aracnet.com ([216.99.193.44]:11242 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261754AbTDLVcu (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 17:32:50 -0400
Date: Sat, 12 Apr 2003 14:17:08 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 576] New: IDE module loop 
Message-ID: <240180000.1050182228@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=576

           Summary: IDE module loop
    Kernel Version: 2.5.67
            Status: NEW
          Severity: normal
             Owner: alan@lxorguk.ukuu.org.uk
         Submitter: jochen@scram.de


Distribution:Debian unstable
Hardware Environment:Alpha Miata 500au
Software Environment:module-init-tools 0.9.11
Problem Description:Compiling IDE subsystem as modules results in module loop

Steps to reproduce:Compile all IDE components as modules
Run depmod -ae 2.5.67

WARNING: Loop detected: /lib/modules/2.5.67/kernel/drivers/ide/ide-iops.ko needs ide.ko which needs ide-iops.ko again!

