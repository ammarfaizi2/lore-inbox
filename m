Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTEUPjL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 11:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTEUPjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 11:39:11 -0400
Received: from franka.aracnet.com ([216.99.193.44]:3045 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262174AbTEUPjK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 11:39:10 -0400
Date: Wed, 21 May 2003 08:52:06 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 734] New: compilation parse error in mwavedd.h before "wait_queue_head_t" 
Message-ID: <22830000.1053532326@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: compilation parse error in mwavedd.h before
                    "wait_queue_head_t"
    Kernel Version: 2.5.69
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: smart@smartpal.de


Distribution:RedHat 8
Hardware Environment:Dell Latitude C640
Software Environment:Kernel only
Problem Description:

Steps to reproduce:
Im not sure if the driver matches, but no matter...

lspci: 00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02)

CONFIG_MWAVE=m

in the make modules phase, compilation of drivers/char/mwave/smapi.c:53 bails
out in including
drivers/char/mwave/mwavedd.h
129: prse err bfore "wait_queue_head_t"
140: prse err bfore "MWAVE_IPC"

