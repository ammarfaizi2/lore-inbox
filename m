Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161110AbWAHTfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbWAHTfL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161123AbWAHTfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:35:10 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:17054 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1161110AbWAHTfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:35:09 -0500
Date: Sun, 8 Jan 2006 20:35:08 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: vherva@vianova.fi, linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
In-Reply-To: <20060108055322.18d4236e.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.61.0601082034150.15902@yvahk01.tjqt.qr>
References: <20060105045212.GA15789@redhat.com> <Pine.LNX.4.61.0601050907510.10161@yvahk01.tjqt.qr>
 <20060105103339.GG20809@redhat.com> <20060108133822.GD31624@vianova.fi>
 <20060108055322.18d4236e.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I believe kmsgdump (http://www.xenotime.net/linux/kmsgdump/) uses its own
>> minimal 16-bit floppy driver to save the oops dump. 
>
>It just switches to real mode and uses BIOS calls.
>

This technique btw is what I suggested (switch to 80x50 vga mode
(if not in X)) in case of a longer oops trace.


Jan Engelhardt
-- 
