Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266979AbUBEWiV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 17:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266995AbUBEWiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 17:38:20 -0500
Received: from hera.cwi.nl ([192.16.191.8]:3820 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S266979AbUBEWiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 17:38:19 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 5 Feb 2004 23:38:16 +0100 (MET)
Message-Id: <UTC200402052238.i15McGD24058.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.2 did not boot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just for the record:
Vanilla 2.6.2 does not boot for me - it crashes immediately after
"Decompressing..". Applying Andi's patch to arch/i386/kernel/process.c
fixes this. I see that this patch went into bk an hour ago.
