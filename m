Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266215AbUG0BKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266215AbUG0BKV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 21:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUG0BKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 21:10:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:20692 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266212AbUG0BHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 21:07:31 -0400
Date: Mon, 26 Jul 2004 18:06:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Andrew Chew" <achew@nvidia.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH 2.6.8-rc2] intel8x0.c to include CK804 audio support
Message-Id: <20040726180601.3b88d166.akpm@osdl.org>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B03F95EF@hqemmail02.nvidia.com>
References: <DBFABB80F7FD3143A911F9E6CFD477B03F95EF@hqemmail02.nvidia.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andrew Chew" <achew@nvidia.com> wrote:
>
> I sincerely apologize about the mangled patch.  I'll be more careful
> next time (and check my mailer settings).

Is OK - you're in good company ;)

> The #ifdef was for consistency (I noticed that there were other IDs
> similarly defined in intel8x0.c).  I don't see why we'd need it, either.
> We should probably remove PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO and
> PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO #defines from intel8x0.c as well, as
> they're similarly redundant.  For that matter, why not remove all of the
> PCI_DEVICE_ID_* #defines from the intel8x0.c driver, and make sure the
> device IDs are defined in pci_ids.h.
> 
> Want me to submit a patch for that?

Let's leave that up to Jeff.
