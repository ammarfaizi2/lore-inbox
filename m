Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUCDOKb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 09:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbUCDOKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 09:10:31 -0500
Received: from math.ut.ee ([193.40.5.125]:20926 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261914AbUCDOK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 09:10:27 -0500
Date: Thu, 4 Mar 2004 16:09:53 +0200 (EET)
From: Meelis Roos <mroos@math.ut.ee>
To: Brian Gerst <bgerst@didntduck.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3: PnPBIOS hangs with S875WP1 BIOS
In-Reply-To: <40473461.80105@quark.didntduck.org>
Message-ID: <Pine.GSO.4.44.0403041607410.2398-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Try this patch

Well, it gets a little further. No oops but a different hang:

Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f3e90
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x44ba, dseg 0xf0000
PNPBIOS fault.. attempting recovery.
double fault, gdt at c0488100 [255 bytes]
double fault, tss at c0530800
eip = f7fa1ea6, esp = 00000028
eax = 00000028, ebx = f7fa1ea6, ecx = c048c5d4, edx = 00000086
esi = 00000000, edi = c010c958

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/

