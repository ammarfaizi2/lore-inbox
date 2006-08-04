Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161478AbWHDV0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161478AbWHDV0d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161480AbWHDV0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:26:33 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:34175 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161478AbWHDV0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:26:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BGuatbuMNAUYo22w1aEjV76n90pbj+UIsdzaYLuNGVUIMcwFLCZQk0rKppAdaFxWLUAxgUchm7yDS6bpfP0pnxw4GJup5PJsiyzPvpfXbv32aAT1cdkH1pm36ayctkEXl5oM5/o/wAQYpiISxwJmpN7dpwIOPvYO/uiDtJfiXjI=
Message-ID: <6839943e0608041426t3433dca5r674633b508e6a748@mail.gmail.com>
Date: Fri, 4 Aug 2006 16:26:28 -0500
From: "Buzz B" <linuxun@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ACPI Errors with AMD 64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

 Built a barebones to use as a Ubuntu server:
 MSI RX480 Neo2 K8 S939 AMD Athlon 64 mobo
 CPU AMD Sempron 3000+ 1.8ghz socket 939

 The errors that are occurring are the same for the following discs:
 Ubuntu 6.06 Desktop
 Ubuntu 6.06 Desktop 64
 Ubuntu 6.06 Alternate 64
 Ubuntu 5.1 and etc... so everything I've tried.
 MD5's checked on all okay.

 In BIOS with ACPI turned OFF then booting from CD:
 Decompressing the kernel.
 Booting the kernel.
 ACPI: Unable to locate RSDP
 MP-BIOS bug: 8254 timer not connected to IO-APIC

 In BIOS with ACPI turned ON then booting from CD:
 Decompressing the kernel.
 Booting the kernel.
 ACPI: Unable to load the system description tables

 And in both cases it freezes right there.
 Just for grins I also tried swapping out the CD and HDD's.
 Same errors.

 I'm at a loss on what's going on here.  It seems it's with power management.

 I haven't been able to find a list of CD boot codes, but through the
forums I have tried all of the following.
 noacip, nolacip, noaicp, nolaicp, acip=off, aicp=off, noapm, apm=off
 Using them still results in the same two errors.

 Also tried Mepis and Slack and they both freeze after they try to
release unused kernel memory right after their boot cd's start their
installs.

 Not sure what else to try or exactly what these ACPI errors are
complaining about.
 Any help would be appreciated.
