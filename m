Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266078AbTAJT5j>; Fri, 10 Jan 2003 14:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266115AbTAJT5j>; Fri, 10 Jan 2003 14:57:39 -0500
Received: from [207.61.129.108] ([207.61.129.108]:29888 "EHLO
	mail.datawire.net") by vger.kernel.org with ESMTP
	id <S266078AbTAJT5i>; Fri, 10 Jan 2003 14:57:38 -0500
From: Shawn Starr <shawn.starr@datawire.net>
Organization: Datawire Communication Networks Inc.
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG][2.5.55][SCSI] - DV failed to configure device
Date: Fri, 10 Jan 2003 15:06:22 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200301101506.22191.shawn.starr@datawire.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This machine is a Pentium 233MMX 
AP/AX 53 Motherboard from AOpen

Adaptec SCSI card (if I remember the box said 2902)

This is the new Adaptec AIC7XXX driver not old one.

Here is from dmesg:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.26
        <Adaptec 2902/04/10/15/20/30C SCSI adapter>
        aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

scsi0:A:4:0: DV failed to configure device.  Please file a bug report against 
this driver.
  Vendor: HP        Model: T4000s            Rev: 1.10
  Type:   Sequential-Access                  ANSI SCSI revision: 02
st: Version 20021214, fixed bufsize 32768, wrt 30720, s/g segs 256
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
st0: try direct i/o: yes, max page reachable by HBA 1048575

-- 
Shawn Starr
UNIX Systems Administrator, Operations
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008
shawn.starr@datawire.net
"The power to Transact" - http://www.datawire.net

