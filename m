Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263469AbTDIOdR (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 10:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbTDIOdR (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 10:33:17 -0400
Received: from franka.aracnet.com ([216.99.193.44]:5294 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263469AbTDIOdN (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 10:33:13 -0400
Date: Wed, 09 Apr 2003 07:07:25 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 560] New: Wacom driver isn't working
Message-ID: <179750000.1049897245@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=560

           Summary: Wacom driver isn't working
    Kernel Version: 2.5.66
            Status: NEW
          Severity: normal
             Owner: vojtech@suse.cz
         Submitter: simon@ulsnes.dk


Distribution: Gentoo 1.4r2 
 
Hardware Environment: AMD Athlon 650 MHz, VIA KT133 motherboard 
 
Software Environment: XFree 4.3.0, KDE 3.1.1 
 
Problem Description: The wacom driver simply doesn't work. Everything _looks_ ok, 
but the tablet (a USB Graphire2) doesn't respond. The driver is loaded OK and 
XFree reports that the tablet is found (on /dev/input/event1), so does the kernel 
when the driver is compiled in. 
On kernels 2.4.18 through 2.4.20, everything worked OK with similar kernel 
configurations. 
Please, I need my tablet! (and I need 2.5.x :) 
 
Steps to reproduce: 
1. Connect your Wacom Graphire2 tablet to your USB-port. (haven't tried the 
Intous series) 
2. Compile kernel 2.5.x with Wacom Tablet support either as a module or 
compiled-in. 
3. Modify /etc/X11/XF86Config to match your tablet. 
4. Realize that nothing works... :-( 
 

