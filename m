Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbUCRQkw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 11:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUCRQkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 11:40:52 -0500
Received: from law10-f95.law10.hotmail.com ([64.4.15.95]:30482 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262743AbUCRQkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 11:40:51 -0500
X-Originating-IP: [141.156.159.253]
X-Originating-Email: [jpiszcz@hotmail.com]
From: "Justin Piszcz" <jpiszcz@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux Kernel Microcode Question
Date: Thu, 18 Mar 2004 16:40:49 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F95ihL5C2Skqk00028182@hotmail.com>
X-OriginalArrivalTime: 18 Mar 2004 16:40:50.0073 (UTC) FILETIME=[C562B890:01C40D07]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The URL: http://www.urbanmyth.org/microcode/

The microcode_ctl utility is a companion to the IA32 microcode driver 
written by Tigran Aivazian <tigran@veritas.com>. The utility has two uses:

    * it decodes and sends new microcode to the kernel driver to be uploaded 
to Intel IA32 processors. (Pentium Pro, PII, PIII, Pentium 4, Celeron, Xeon 
etc - all P6 and above, which does NOT include pentium classics)
    * it signals the kernel driver to release any buffers it may hold

The microcode update is volatile and needs to be uploaded on each system 
boot i.e. it doesn't reflash your cpu permanently, reboot and it reverts 
back to the old microcode.

My question is, what are the advantages vs disadvantages in updating your 
CPU's microcode?

Is it worth it?

Does it matter what type of Intel CPU you have?

Do some CPU's benefit more than others for microcode updates?

I know RedHat distributions usually do this by default, but others do not.

Can anyone explain reasons to or not to update the CPU microcode?

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar – get it now! 
http://clk.atdmt.com/AVE/go/onm00200415ave/direct/01/

