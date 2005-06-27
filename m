Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVF0SvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVF0SvP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 14:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVF0SvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 14:51:15 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:6764 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261582AbVF0SvN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 14:51:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fomysrSAwCQuQhPwoY3XWeAkXpb/IXKN/IOsSSnxVY4z/pLrj4fM1XkbbOPiMc1ges2DUoiQdALTj6LukIM+c0IQmmLvsQReMOEBoKEMrfPeOaDNeu80jeWrgE2/9JYRxXn5CHiFlw7Vn61EYYmVMYhgmsxhZM7uJugG/EUYsLM=
Message-ID: <2d4e1ff6050627115141bb2828@mail.gmail.com>
Date: Mon, 27 Jun 2005 20:51:12 +0200
From: Stefano Mangione <s.mangione@gmail.com>
Reply-To: Stefano Mangione <s.mangione@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.12] USB storage device stalls after a few KB transfer
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The device is seen, can be mounted and the filesystem listed, but file
transfers run very slow, i guess they stop after a few KB.

This happened in 2.6.12, 2.6.11.12 works well, everything else seems
to work perfectly. The device is a 256MB OTi Flash Disk, my USB host
is listed as a VIA VT6202, the motherboard is an MSI with A6712VMS
V1.9 072903 BIOS

/sbin/lspci -n:
00:10.0 Class 0c03: 1106:3038 (rev 80)
00:10.1 Class 0c03: 1106:3038 (rev 80)
00:10.2 Class 0c03: 1106:3038 (rev 80)
00:10.3 Class 0c03: 1106:3104 (rev 82)

I didn't subscribe to the list, so please Cc: me in replies
