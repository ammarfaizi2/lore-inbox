Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbTKVVtC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 16:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbTKVVtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 16:49:02 -0500
Received: from mid-2.inet.it ([213.92.5.19]:4534 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S262772AbTKVVs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 16:48:59 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Pete Clements <clem@clem.clem-digital.net>,
       James.Bottomley@SteelEye.com (James Bottomley)
Subject: Re: 2.6.0-test9-bk26 fails boot -- aic7890 detection
Date: Sat, 22 Nov 2003 22:48:44 +0100
User-Agent: KMail/1.5.4
References: <200311222109.QAA10536@clem.clem-digital.net>
In-Reply-To: <200311222109.QAA10536@clem.clem-digital.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311222248.44381.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 22:09, sabato 22 novembre 2003, Pete Clements ha scritto:
>   >
>   > I've never successfully managed to get the aic7xxx driver to work on my
>   > parisc platform.  However, both with and without the latest SCSI diffs
>   > the behaviour seems the same (it does print out the driver banner
>   > before failing to connect to the drives).  I take it you aren't seeing
>   > this banner?
>
> Correct, no banner and bk26 has a scsi_scan change.

I'm seeing the same behaviour on my machine (t9-bk26,SMP,HT,preeemp,P4), the 
last line displayed is:
ahc_pci:3:6:0: Host Adapter Bios disabled.  Using default SCSI device 
parameters

And after this the boot procedure is stopped.

The following message, with bk23, is:
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
         <Adaptec 2902/04/10/15/20/30C SCSI adapter>
         aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

HTH

-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

