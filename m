Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbTBPUOP>; Sun, 16 Feb 2003 15:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267362AbTBPUOO>; Sun, 16 Feb 2003 15:14:14 -0500
Received: from franka.aracnet.com ([216.99.193.44]:32454 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266010AbTBPUOK>; Sun, 16 Feb 2003 15:14:10 -0500
Date: Sun, 16 Feb 2003 12:24:01 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 369] New: opl3sa2.c fails to compile because on PNP error
Message-ID: <28780000.1045427041@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=369

           Summary: opl3sa2.c fails to compile because on PNP error
    Kernel Version: 2.5.61
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: donaldlf@i-55.com


Distribution:redhat
Hardware Environment:LX164 / alpha
Software Environment:rawhide
Problem Description:

when building modules the file linux/sound/isa/opl3sa2.c
reports compile errors. (PNP seems to be the cause.)

I have patched it. my patch is included as an attachment.

Steps to reproduce:

select opl mixer compile


