Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbUKAMCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbUKAMCb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 07:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbUKAMCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 07:02:30 -0500
Received: from cantor.suse.de ([195.135.220.2]:13727 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261720AbUKAMC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 07:02:28 -0500
Date: Mon, 1 Nov 2004 13:02:27 +0100
From: Olaf Hering <olh@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disambiguation for panic_timeout's sysctl
Message-ID: <20041101120227.GA24626@suse.de>
References: <Pine.LNX.4.53.0410311721470.20529@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0410311721470.20529@yvahk01.tjqt.qr>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Oct 31, Jan Engelhardt wrote:

> 
> 
> The /proc/sys/kernel/panic file looked to me like it was something like
> /proc/sysrq-trigger -- until I looked into the kernel sources which reveal that
> it sets the variable "panic_timeout" in kernel/sched.c.

This will probably break applications that expect the filename 'panic'.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
