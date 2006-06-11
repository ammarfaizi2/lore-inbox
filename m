Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWFKXaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWFKXaq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 19:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWFKXaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 19:30:46 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:36302 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751120AbWFKXap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 19:30:45 -0400
Date: Mon, 12 Jun 2006 01:30:27 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matt Mackall <mpm@selenic.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] x86 built-in command line
In-Reply-To: <20060611215530.GH24227@waste.org>
Message-ID: <Pine.LNX.4.61.0606120129230.8102@yvahk01.tjqt.qr>
References: <20060611215530.GH24227@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>This patch allows building in a kernel command line on x86 as is
>possible on several other arches.
>
>+config CMDLINE
>+	  On some systems, there is no way for the boot loader to pass
>+	  arguments to the kernel. For these platforms, you can supply
>+	  some command-line options at build time by entering them
>+	  here. In most cases you will need to specify the root device
>+	  here.

Thank God x86 does not have that limitation. Or am I missing some exotic 
bootloader that fails to pass in arguments?


Jan Engelhardt
-- 
