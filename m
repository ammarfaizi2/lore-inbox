Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262857AbTDAU6Z>; Tue, 1 Apr 2003 15:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262931AbTDAU6Z>; Tue, 1 Apr 2003 15:58:25 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:64935 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262857AbTDAU6X>; Tue, 1 Apr 2003 15:58:23 -0500
Date: Tue, 01 Apr 2003 12:59:46 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: linux-kernel <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 530] New: dma not enabled for IDE hard drives 
Message-ID: <137350000.1049230786@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=530

           Summary: dma not enabled for IDE hard drives
    Kernel Version: 2.5.66
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: freelsjd@ornl.gov


Distribution: Debian/Sid

Hardware Environment: dual 2.4Ghz Xeon, SE7500CW2 MB, all Intel
                      Promise PDC20267 ATA-100 ide channels in
                      non-RAID mode

Software Environment: testing with hdparm 5.2-1 of Debian/Sid

Problem Description:

I have similar .config settings for both the 2.4.20 and the 2.5.66
kernels with the identical machine.  Under 2.4.20, I do get dma enabled 
and see good performance (Mb/s) from the hard disk I/O.  

However, under the 2.5.66 kernel, dma is not enabled and the performance 
of the hard drives is poor (~2-3 Mb/s under 2.4.20 versus ~30 Mb/s under 
2.5.66).  The "hdparm -I /dev/hda" command confirms that dma is not
enabled under 2.5.66, but is under 2.4.20.


Steps to reproduce:

