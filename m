Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbUL1Pbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbUL1Pbz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 10:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUL1Pbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 10:31:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:59549 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261785AbUL1Pbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 10:31:53 -0500
Subject: Re: Problems with 2.6.10
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Fryderyk Mazurek <dedyk@go2.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041227171159.51454193BFA@r10.go2.pl>
References: <20041227171159.51454193BFA@r10.go2.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104238047.20952.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Dec 2004 14:27:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-27 at 17:11, Fryderyk Mazurek wrote:
> Hi everyone!
> 
> I have so strange problem with kernel 2.6.10. Kernel works good, but
> problem starts when I do reboot. On boot screen my bios can't detect
> my disk. Bios stops and nothing. So without end. Button reset on my
> towel can't fix it. To fix this situation I must turn off and turn
> on my computer. Only it helps. With kernel 2.6.9 wasn't so problem.
> How to fix it?

The IDE code is meant to spin the drive down on poweroff but not on
"reboot". If the new power changes upset this then a few boxes will do
as you describe because the BIOS isn't bright enough to get the drive
powered back up.

Alan

