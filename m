Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUBEE2T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 23:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUBEE2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 23:28:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:55198 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262902AbUBEE2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 23:28:18 -0500
Date: Wed, 4 Feb 2004 20:30:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: mikem@beardog.cca.cpqcorp.net
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: cciss updates for 2.6 [1 of 11]
Message-Id: <20040204203000.035e9193.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402041737080.18320@beardog.cca.cpqcorp.net>
References: <Pine.LNX.4.58.0402041737080.18320@beardog.cca.cpqcorp.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikem@beardog.cca.cpqcorp.net wrote:
>
> Patch 1 of 11. Please apply in order.

You seem to have used an email client which trims off all trailing
whitespace.  But `patch -l' happily applied everything so that's OK.

For next time: we don't normally use a cast to indicate that we're
deliberately discarding return values.

+	(void) pci_read_config_word(pdev, PCI_COMMAND,&command);

Thanks.
