Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWDTWGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWDTWGy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWDTWGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:06:54 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:10905 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932073AbWDTWGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:06:54 -0400
Date: Fri, 21 Apr 2006 00:06:37 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Mikado <mikado4vn@gmail.com>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Which process is associated with process ID 0 (swapper)
In-Reply-To: <Pine.LNX.4.61.0604201118200.5749@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0604210004120.28841@yvahk01.tjqt.qr>
References: <4447A19E.9000008@gmail.com> <Pine.LNX.4.61.0604201118200.5749@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Subject: Re: Which process is associated with process ID 0 (swapper)
>
>This must be a trick question. Linux is not VAX/VMS. There is no
>swapper process. Check in /proc. Processes start at 1. Even
>kernel threads have PIDs greater than 1.
>

The initialization code which runs before the first userspace program is 
invoked (usually /sbin/init) could be termed 'process 0'.



Jan Engelhardt
-- 
