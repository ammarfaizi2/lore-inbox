Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVEWVNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVEWVNj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 17:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVEWVNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 17:13:38 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:14368 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261970AbVEWVNd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 17:13:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bvNUWqOhkxvayZnY2/r+BM+AXWSU9Wz9X2OJxaW/CIPCnoNQAsXEdNPHgeI1NDse50KM16hx/0o44aJXoJE6L7tsvt07OuSnaJjzG9jp5yPB9MaOOQSC9lWm00quAJ8Bb0g1GUFaQJ1wfSlWKi4de9TkIWydqREQP1wvwM8zbyU=
Message-ID: <c775eb9b0505231413189c035b@mail.gmail.com>
Date: Mon, 23 May 2005 17:13:32 -0400
From: Bharath Ramesh <krosswindz@gmail.com>
Reply-To: Bharath Ramesh <krosswindz@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Dual opteron freezed with Machine Check Exception
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a dual opteron storage server running Gentoo with 2.6.9-gentoo-r1 kernel.

The machine freezes on reboot with last line printing the following mce

CPU 0: Machine Check exception                    7 Bank 4: b442200000000a13
RIP 10: <ffffffff8010fb44> {default_idle+0x24/0x30}
TSC c39e79e0c ADDR 3d1c2870
Kernel Panic - not syncing: Uncorrected machine check

I need to perform a hard reboot. It starts working fine. This happens
only during reboots and I never see any other machine check exceptions
when the system is up and running. Any help as to what could be going
wrong.

Thanks

Bharath
