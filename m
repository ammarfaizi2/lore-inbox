Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269356AbUJWBUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269356AbUJWBUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269586AbUJWAe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:34:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:63199 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269524AbUJWA2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:28:20 -0400
Date: Fri, 22 Oct 2004 17:32:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: markus@trippelsdorf.net, linux-kernel@vger.kernel.org
Subject: Re: BT848 video support dropped in 2.6.9?
Message-Id: <20041022173214.5bc8c316.akpm@osdl.org>
In-Reply-To: <4178FAB4.9070208@kolivas.org>
References: <1098447230.12289.12.camel@localhost>
	<4178FAB4.9070208@kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Markus Trippelsdorf wrote:
> > The "BT848 video for linux" item does not show up
> > with menuconfig in the "Video for linux" category.
> > It was there in all previous kernels that I've used.
> > Am I missing something obvious?
> 
> config VIDEO_BT848
> 	depends on VIDEO_DEV && PCI && I2C && FW_LOADER

Or you can do `make menuconfig' then hit "/BT848".  I love that feature!
