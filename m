Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVBGUde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVBGUde (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 15:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVBGTwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:52:43 -0500
Received: from mail0.lsil.com ([147.145.40.20]:13014 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261274AbVBGTpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:45:23 -0500
Message-ID: <91888D455306F94EBD4D168954A9457C01297B87@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: EBDA Question
Date: Mon, 7 Feb 2005 12:45:17 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EBDA - Extended Bios Data Area

Does Linux and various boot loaders(lilo/grub/etc)
having any restrictions on where and how big 
memory allocated in EBDA is? Is this
handled for 2.4/2.6 Kernels?

Reason I ask is we are considering having
BIOS(for a SCSI HBA Controller) allocating
memory in EBDA for Firmware use. 
We are concerned whether Linux would be writing
over this region of memory during the handoff
of BIOS to scsi lower layer driver loading.

Eric Moore
LSI Logic
