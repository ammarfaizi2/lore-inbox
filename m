Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268161AbUHFP5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268161AbUHFP5U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268162AbUHFPuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:50:23 -0400
Received: from s-und-t-linnich.de ([217.160.180.132]:32995 "HELO
	s-und-t-linnich.de") by vger.kernel.org with SMTP id S268156AbUHFPsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:48:18 -0400
Date: Fri, 6 Aug 2004 19:47:22 +0200
From: "admin@wodkahexe.de" <admin@wodkahexe.de>
To: linux-kernel@vger.kernel.org
Subject: MTRR problem, maybe FB related
Message-Id: <20040806194722.6298b00f.admin@wodkahexe.de>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

i'm getting the following problem since 2.6.8-rc1. maybe with 2.6.7 too, i don't remember.

vesafb: framebuffer at 0xb0000000, mapped to 0xdf80d000, size 6144k
vesafb: mode is 1024x768x32, linelength=4096, pages=4
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: directcolor: size=8:8:8:8, shift=24:16:8:0
.
.
.

agpgart: AGP aperture is 128M @ 0xb0000000
mtrr: 0xb0000000,0x8000000 overlaps existing 0xb0000000,0x400000
[drm] Initialized i830 1.3.2 20021108 on minor 0: Intel Corp. 82852/855GM Integrated Graphics Device
mtrr: 0xb0000000,0x8000000 overlaps existing 0xb0000000,0x400000
[drm] Initialized i830 1.3.2 20021108 on minor 1: Intel Corp. 82852/855GM Integrated Graphics Device (#2)


when starting X i'm getting the following in dmesg:

mtrr: base(0xb0020000) is not aligned on a size(0x180000) boundary
mtrr: 0xb0000000,0x8000000 overlaps existing 0xb0000000,0x400000

is there any way to get both working together? (fb + mtrr)

Thanks, sebastian
