Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282962AbRLMBBR>; Wed, 12 Dec 2001 20:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282966AbRLMBBG>; Wed, 12 Dec 2001 20:01:06 -0500
Received: from palrel13.hp.com ([156.153.255.238]:13838 "HELO palrel13.hp.com")
	by vger.kernel.org with SMTP id <S282962AbRLMBAz>;
	Wed, 12 Dec 2001 20:00:55 -0500
Message-ID: <C5C45572D968D411A1B500D0B74FF4A80418D5E7@xfc01.fc.hp.com>
From: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
To: "Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Cc: "PATTERSON,ANDREW (HP-Loveland,ex2)" <andrew_patterson@hp.com>
Subject: kernel panic with 2.4.16 and blockhighmem patch
Date: Wed, 12 Dec 2001 17:00:39 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting a kernel panic when running specSFS on a 4x700PIII xeon highmem
system with 4GB RAM.  We connect to our storage with a qlogicfc card and
have dual Gig Nics to the network.  The filesystem is xfs.

The final message is:
scsi_free:Bad offset
In interrupt handler - not syncing

I complete the test fine with vanilla 2.4.16, and am wondering if this has
been seen elsewhere.  Any ideas what would be causing this or, how I should
fix it, would be appreciated.

Cary

