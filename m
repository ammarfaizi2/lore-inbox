Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265009AbTFWDm6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 23:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265022AbTFWDm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 23:42:58 -0400
Received: from franka.aracnet.com ([216.99.193.44]:16007 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265009AbTFWDm5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 23:42:57 -0400
Date: Sun, 22 Jun 2003 20:56:57 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 843] New: Getting very high CPU load on Laptop with ACPI
Message-ID: <280990000.1056340617@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Getting very high CPU load on Laptop with ACPI
    Kernel Version: 2.5.72 (and others with new acpi code)
            Status: NEW
          Severity: normal
             Owner: andrew.grover@intel.com
         Submitter: hanno@gmx.de


I own a fujitsu-siemens lifebook C6155.
With several linux-kernels containing the new acpi (2.5.x, 2.4.21+patch,
2.4.21-ac1), I get very high CPU-load every few seconds. It's even impossible to
listen mp3s.
top shows me that it's the process events on 2.5-kernels and keventd on 2.4-kernels.
This does not happen with 2.4.21-vanilla (without acpi-patch, but with acpi
enabled and working).
So the bug seems to be in the new acpi-system.
Attached is dmesg-output (with 2.4 and 2.5), the dsdt, lspci-output and a
screenshot of gkrellm showing the cpu-usage (on a system running nothing that
consumes cpu-power).

