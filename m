Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbUKBWWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUKBWWc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUKBWWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:22:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:55449 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261462AbUKBWWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:22:04 -0500
Date: Tue, 2 Nov 2004 14:26:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix missing includes for isdn diversion
Message-Id: <20041102142602.402316ef.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0411020749010.13921@yvahk01.tjqt.qr>
References: <Pine.LNX.4.53.0411020749010.13921@yvahk01.tjqt.qr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> # File:  isdn_divert.diff
> # Class: missing prototype addition
> #
> # Adds #include <linux/interrupt.h> to resolve missing calls to cli(),
> # sti() and restore_flags().
> 
> 
> 
> Signed-off by: Jan Engelhardt <jengelh@linux01.gwdg.de>
> 
> 
> diff -dpru linux-2.6.4-52/drivers/isdn/divert/divert_init.c

This appears to be against a 2.6.4 kernel, yes?

The problem might have been fixed in the intervening months.  Please
confirm that the bug still exists in 2.6.10-rc1 and if so, send an updated
patch.

Thanks.

