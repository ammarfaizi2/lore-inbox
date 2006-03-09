Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbWCIMP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbWCIMP4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWCIMP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:15:56 -0500
Received: from pih-relay04.plus.net ([212.159.14.131]:23218 "EHLO
	pih-relay04.plus.net") by vger.kernel.org with ESMTP
	id S932579AbWCIMPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:15:55 -0500
Message-ID: <44101C75.7080801@lesshaste.plus.com>
Date: Thu, 09 Mar 2006 12:15:49 +0000
From: Raphael <mencoder@lesshaste.plus.com>
User-Agent: Mail/News 1.5 (X11/20060226)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG: msi rs480m2 gives APIC and timing errors
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my MSI rs480m2 mobo using all kernels up to and including  2.6.16-rc5
I get a number of errors in dmesg immediately on boot that look like

time.c: Lost 13 timer tick(s)! rip 0x95f51e)
time.c: Lost 15 timer tick(s)! rip default_idle+0x36/0x80)
APIC error on CPU0: 04(40)
time.c: Lost 13 timer tick(s)! rip 0x823d49b)
time.c: Lost 15 timer tick(s)! rip default_idle+0x36/0x80)
time.c: Lost 13 timer tick(s)! rip 0x5b9bf2)
time.c: Lost 15 timer tick(s)! rip default_idle+0x36/0x80)
APIC error on CPU0: 40(40)
time.c: Lost 1 timer tick(s)! rip default_idle+0x36/0x80)
time.c: Lost 14 timer tick(s)! rip clear_page+0x7/0x10)
time.c: Lost 15 timer tick(s)! rip default_idle+0x36/0x80)



Bug report at http://bugme.osdl.org/show_bug.cgi?id=6198

Raphael
