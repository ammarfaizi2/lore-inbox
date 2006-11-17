Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752933AbWKQT5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbWKQT5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752942AbWKQT5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:57:53 -0500
Received: from smtp.osdl.org ([65.172.181.25]:944 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752929AbWKQT5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:57:52 -0500
Date: Fri, 17 Nov 2006 11:54:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@redhat.com>
Subject: Re: [-mm patch] remove
 drivers/pci/search.c:pci_find_device_reverse()
Message-Id: <20061117115404.4bc87cf9.akpm@osdl.org>
In-Reply-To: <20061117142145.GX31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061117142145.GX31879@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 15:21:45 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> This patch removes the no longer used pci_find_device_reverse().

But it is exported to modules.

This is what we created EXPORT_UNUSED_SYMBOL() for.
