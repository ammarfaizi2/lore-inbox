Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWCZGlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWCZGlI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 01:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWCZGlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 01:41:08 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:38597 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1750979AbWCZGlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 01:41:06 -0500
Message-ID: <4426377C.7000605@tlinx.org>
Date: Sat, 25 Mar 2006 22:41:00 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Block I/O Schedulers: Can they be made selectable/device? @runtime?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it still the case that block I/O schedulers (AS, CFQ, etc.)
are only selectable at boot time?

How difficult would it be to allow multiple, concurrent I/O
schedulers running on different block devices?

How close is the kernel to "being there"?  I.e. if someone has a
"regular" hard disk and a high-end solid state disk, can
Linux allow whichever algorithm is best for the hardware?
(or applications if they are run on separate block devices)?

-l




