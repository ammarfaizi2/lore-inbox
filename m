Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbUADTBL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 14:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUADTBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 14:01:11 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:46864 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S262360AbUADTBI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 14:01:08 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6 kernel oops at boot time (repeatable each time, 2.6.0, 2.6.1rc1)
Date: Sun, 4 Jan 2004 20:00:54 +0100
User-Agent: KMail/1.5.94
References: <200401041746.52826.arekm@pld-linux.org>
In-Reply-To: <200401041746.52826.arekm@pld-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401042000.54155.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 of January 2004 17:46, Arkadiusz Miskiewicz wrote:
> The kernel 2.6.1rc1 oopses:
>
> Linux Plug and Play Support v0.97 (c) Adam Belay
> PnPBIOS: Scanning system for PnP BIOS support...
> PnPBIOS: Found PnP BIOS installation structure at 0xc00f3450
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x3a6a, dseg 0xf0000
> general protection fault: 0000 [#1]
> CPU:    0
> EIP:    0098:[<00001013>]    Not tainted
> EFLAGS: 00010097
> EIP is at 0x1013
> eax: 00002514   ebx: 000000a2   ecx: 00010000   edx: 00000001
> esi: ded7086c   edi: 000100b2   ebp: deed0000   esp: deed1ec2
> ds: 00b0   es: 00b0   ss: 0068
> Process swapper (pid: 1, threadinfo=deed0000 task=dee5f900)
> Stack: 00000514 25140e82 00000000 42af00b2 0000ad68 00010001 1f144240
> 00b2ad71 1f140000 ad681ef0 00060001 3d290c0c 010c010c 007b3b84 00b0007b
> 00a0c000 3b4000b0 00a83b06 1f640096 000bdeed 00010090 00a80000 00b00000
> 00a00001 Call Trace:
>
> Code:  Bad EIP value.
>  <0>Kernel panic: Attempted to kill init!
>  <0>Rebooting in 10 seconds

pnpbios=off and kernel boots properly!

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux
