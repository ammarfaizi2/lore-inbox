Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269771AbUJVIL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269771AbUJVIL4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 04:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269743AbUJVILz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 04:11:55 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:62428 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S269848AbUJVIHn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 04:07:43 -0400
Message-ID: <4178BFCC.50804@free.fr>
Date: Fri, 22 Oct 2004 10:07:40 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SCSI adaptec 2940 : problem since 2.6.9 and up to 2.6.9-bk6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the log message I get :

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
         <Adaptec 2940 Ultra SCSI adapter>
         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

(scsi0:A:3:0): Unexpected busfree in Message-out phase
SEQADDR == 0x16f
(scsi0:A:3:0): Unexpected busfree in Message-out phase
SEQADDR == 0x16f
(scsi0:A:3:0): Unexpected busfree in Message-out phase
SEQADDR == 0x16f

several ten's of such lines removed
...

The second different model works fine though :

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
         <Adaptec 29160 Ultra160 SCSI adapter>
         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi1:A:6): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
   Vendor: QUANTUM   Model: ATLAS10K3_36_WLS  Rev: 020W
   Type:   Direct-Access                      ANSI SCSI revision: 03
scsi1:A:6:0: Tagged Queuing enabled.  Depth 64


Furthermore, my HP DAT allthough correctly detected/probed by SCSI BIOS 
is no more detected...

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



