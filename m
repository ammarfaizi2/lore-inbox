Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266346AbUBLLSe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 06:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266337AbUBLLSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 06:18:32 -0500
Received: from ns.suse.de ([195.135.220.2]:32208 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266363AbUBLLP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 06:15:26 -0500
Date: Thu, 12 Feb 2004 17:51:05 +0100
From: Andi Kleen <ak@suse.de>
To: Paul Menage <menage@google.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Typo in include/asm-x86_64/pci-direct.h ?
Message-Id: <20040212175105.4db84f8d.ak@suse.de>
In-Reply-To: <402B5D09.6030909@google.com>
References: <402B5D09.6030909@google.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004 03:01:29 -0800
Paul Menage <menage@google.com> wrote:

> Hi Andi,
> 
> I noticed that the return value of read_pci_config_16() was a u8, which looks a bit suspicious. The 
> only users of it are in kernel/aperture.c, and appear to work despite only getting 8 bits back, due 
> to lucky circumstances. Patch applies to both 2.4 and 2.6.

Yup, typo apparently. Thanks, I applied the patch.

-Andi
