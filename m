Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTDUPRL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbTDUPRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:17:11 -0400
Received: from franka.aracnet.com ([216.99.193.44]:56481 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261326AbTDUPRI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:17:08 -0400
Date: Mon, 21 Apr 2003 08:29:10 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 610] New: Missing include header causes agp compilation to fail on ppc32
Message-ID: <26370000.1050938950@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=610

           Summary: Missing include header causes agp compilation to fail on
                    ppc32
    Kernel Version: 2.5.68
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: dilinger@voxel.net


Distribution: Debian unstable
Hardware Environment: NewWorld pmac; 7410, altivec supported
Software Environment: gcc version 3.2.3 20030407 (Debian prerelease)
Problem Description: Things including asm/agp.h fail to compile due to missing
header.  Dummy files were added to stuff like asm-sparc64, but not to asm-ppc. 
I   can't verify that this dummy file won't hurt anything, but it worked for me
when I booted up my ppc box into 2.5.68 (using atyfb128) and started X (using
X's rage128 driver).

