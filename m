Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWAVG7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWAVG7G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 01:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWAVG7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 01:59:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24037 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751066AbWAVG7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 01:59:05 -0500
Date: Sat, 21 Jan 2006 22:58:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ariel <askernel2615@dsgml.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
Message-Id: <20060121225845.71cb7cad.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz>
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ariel <askernel2615@dsgml.com> wrote:
>
> I have a memory leak in scsi_cmd_cache.

You're no the only one.  Please send the full `dmesg -s 1000000' output so
we can see which devices and drivers are in use.

Thanks.
