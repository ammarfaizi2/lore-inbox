Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTEPPIH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 11:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264438AbTEPPIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 11:08:07 -0400
Received: from franka.aracnet.com ([216.99.193.44]:44683 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264436AbTEPPIG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 11:08:06 -0400
Date: Fri, 16 May 2003 06:06:52 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 726] New: Battery info/status query called twice through /proc interface 
Message-ID: <255970000.1053090412@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Battery info/status query called twice through /proc
                    interface
    Kernel Version: 2.4.21-rc/acpi 2002-04-24
            Status: NEW
          Severity: normal
             Owner: andrew.grover@intel.com
         Submitter: markus@gaugusch.at


Problem Description:
The acpi code is executed twice when doing 'cat /proc/acpi/BAT1/info' (same with
'state'). I added debug printk's to the appropriate functions to find this out.


