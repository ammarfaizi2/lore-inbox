Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTDQQRb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 12:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbTDQQRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 12:17:30 -0400
Received: from franka.aracnet.com ([216.99.193.44]:22457 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261684AbTDQQR3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 12:17:29 -0400
Date: Thu, 17 Apr 2003 09:29:22 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 595] New: ide-cd stops recognizing cd-rw, starting with
 2.5.67-ac1. 
Message-ID: <15350000.1050596962@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=595

           Summary: ide-cd stops recognizing cd-rw, starting with 2.5.67-
                    ac1.
    Kernel Version: 2.5.67-ac1
            Status: NEW
          Severity: normal
             Owner: alan@lxorguk.ukuu.org.uk
         Submitter: alex@armu.net


Distribution: none 
Hardware Environment: ASUS A7V8X, Promise PDC20376, TEA CD-W552E 
Software Environment: glibc-2.3.2 
Problem Description: ide-cd fails to recognize the CD-RW and subsequently
cdrecord fails  with strange error message. Everything works smoothly with
2.5.67.   
Steps to reproduce: well, modprobe ide-cd and cdrecord dev=/dev/hdx -inq. 
I get 
Vendor_info    : 'ADAPTEC ' 
Identifikation : 'ACB-5500        ' 
Revision       : 'FAKE' 
Device seems to be: Adaptec 5500. 
as identification from cdrecord and ide-cd generates error messages: 
hdc: confused, missing data 
cdrom_newpc_intr: 36 residual after xfer

