Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVGLSng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVGLSng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 14:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVGLSng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 14:43:36 -0400
Received: from bay20-f5.bay20.hotmail.com ([64.4.54.94]:48111 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261547AbVGLSnf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 14:43:35 -0400
Message-ID: <BAY20-F541636D2F7D98F4F9531FC4DF0@phx.gbl>
X-Originating-IP: [128.252.233.247]
X-Originating-Email: [jonschindler@hotmail.com]
In-Reply-To: <2112561.1121094204768.SLOX.WebMail.wwwrun@exchange.deltacomputer.de>
From: "Jon Schindler" <jonschindler@hotmail.com>
To: o.weihe@deltacomputer.de, linux-kernel@vger.kernel.org
Subject: Re: USB storage does not work with 3GB of RAM, but does with 2G of RAM
Date: Tue, 12 Jul 2005 14:43:33 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 12 Jul 2005 18:43:35.0052 (UTC) FILETIME=[9BF314C0:01C58711]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried this last night and enabling the OS2 memory hole in the bios doesn't 
work.  That's the only memory hole option available.  If I were more savvy 
with the kernel memory layout, I might try passing it a set of memmap 
options, but I'm not very familiar with what address spaces I need to set up 
for the kernel or how much space they need, or if there are any rules 
concerning what goes where.  (i.e. the difference between reserved, ACPI, 
etc.)

Thanks anyway for the suggestion,

Jon

>From: Oliver Weihe <o.weihe@deltacomputer.de>
>To: linux-kernel@vger.kernel.org
>Subject: Re: USB storage does not work with 3GB of RAM, but does with 2G of 
>RAM
>Date: Mon, 11 Jul 2005 17:03:24 +0200 (CEST)
>
>Tried different settings for "Soft-/Hardware Memory Hole" in BIOS?
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


