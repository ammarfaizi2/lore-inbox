Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266305AbUAHWHI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 17:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266323AbUAHWHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 17:07:06 -0500
Received: from mail5.bluewin.ch ([195.186.1.207]:30346 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S266305AbUAHWFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 17:05:43 -0500
Message-ID: <3FFDD435.3080808@bluewin.ch>
Date: Thu, 08 Jan 2004 23:05:41 +0100
From: Mario Vanoni <vanonim@bluewin.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, it, fr-fr, de-de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.6.1-rc2-mm1: 4xOK, 1xUNUSABLE
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK: UP's Celeron-1G & P3-550, dual SMP's P3-550 & P3-1266

UNUSABLE: P4-3066HT with 1GB mem

Compiling the kernel under 2.6.1-rc1-mm1, gcc-3.3.2,

arch/i386/boot/setup.S: Assembler messages:
arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to 0x37ffffff

each values 6 (six) f (truncated, what ???)

but compiles.

Rebooting with this kernel the first time OK,
then trying to recompile the kernel,
the machine freezed, no messages.

Rebooting with the same kernel, fsck, same problem.

Rebooting with 2.6.1-rc1-mm1 _no_ _problems_!
Kernel recompiles with the same error messages.

Mario, _not_ in lkml (cc if needed).

