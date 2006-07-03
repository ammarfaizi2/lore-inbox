Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWGCK4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWGCK4x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 06:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWGCK4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 06:56:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20461 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750827AbWGCK4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 06:56:52 -0400
Date: Mon, 3 Jul 2006 03:56:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: tigran@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-Id: <20060703035644.eccdd078.akpm@osdl.org>
In-Reply-To: <6bffcb0e0607030350l497fdeb9ucb924e883fdad29@mail.gmail.com>
References: <20060703030355.420c7155.akpm@osdl.org>
	<6bffcb0e0607030350l497fdeb9ucb924e883fdad29@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006 12:50:26 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> Hi,
> 
> On 03/07/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/
> >
> 
> Something is missing in drivers/base/firmware_class.c?
> 
> WARNING: /lib/modules/2.6.17-mm6/kernel/arch/i386/kernel/microcode.ko
> needs unknown symbol release_firmware
> WARNING: /lib/modules/2.6.17-mm6/kernel/arch/i386/kernel/microcode.ko
> needs unknown symbol request_firmware
> WARNING: /lib/modules/2.6.17-mm6/kernel/arch/i386/kernel/microcode.ko
> needs unknown symbol release_firmware
> WARNING: /lib/modules/2.6.17-mm6/kernel/arch/i386/kernel/microcode.ko
> needs unknown symbol request_firmware
> 

Presumably you'll need CONFIG_FW_LOADER?
