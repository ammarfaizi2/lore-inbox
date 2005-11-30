Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVK3U1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVK3U1e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 15:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbVK3U1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 15:27:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32185 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750719AbVK3U1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 15:27:34 -0500
Date: Wed, 30 Nov 2005 12:27:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc3-mm1
Message-Id: <20051130122719.52a2439e.akpm@osdl.org>
In-Reply-To: <20051130162324.GA15273@infradead.org>
References: <20051129203134.13b93f48.akpm@osdl.org>
	<20051130162324.GA15273@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Nov 29, 2005 at 08:31:34PM -0800, Andrew Morton wrote:
>  > 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc3/2.6.15-rc3-mm1/
>  > 
>  > - Several ISA sound drivers don't compile.  This is due to a collision
>  >   between the ALSA and PCMCIA trees, and to breakage in the ALSA tree.
>  > 
>  > - drivers/serial/jsm/* still doesn't compile.
> 
>  Maybe it's time to drop the driver again?

I was thinking of marking it BROKEN for now.
