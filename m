Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269388AbUJFQmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269388AbUJFQmu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 12:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269386AbUJFQmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 12:42:50 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:23787 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269416AbUJFQZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 12:25:13 -0400
Message-Id: <200410061625.i96GPVu01974@raceme.attbi.com>
Subject: Solaris developer wants a Linux Mentor for drivers.
To: linux-kernel@vger.kernel.org
Date: Wed, 6 Oct 2004 11:25:31 -0500 (CDT)
From: kilian@bobodyne.com (Alan Kilian)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  Kernel folks,

    I am in the process of porting a Sun Solaris PCI bus driver
    that I wrote over to a 2.4 kernel, and I could use a mentor
    just to get me over the initial bumps.

    I have a module that can be loaded, and detects my card, and
    responds to ioctl() calls properly, so I'm moving right along,
    but I do have some problems now.

    1) If I "oops" in my module, I cannot unload it with:
       # /sbin/rmmod sse    
       sse: Device or resource busy

       I have only figured out that a reboot cleans things up again.

    2) An example of using pci_ops read_dword() would be superb.

    By the way, this development environment is really slick
    compared to Solaris. When I "oops" in Solaris, the kernel
    panics and I'm in for a messy fsck on the way back up. This
    is a great improvement.

    Thanks in advance for any help any of you may provide.

    After this, there will be one more Linux PCI bus driver developer
    in the world, and that can't be a bad thing.

                          -Alan

-- 
- Alan Kilian <kilian(at)timelogic.com> 
Director of Bioinformatics, TimeLogic Corporation 763-449-7622
