Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbUC2PZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 10:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbUC2PZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 10:25:56 -0500
Received: from ns.suse.de ([195.135.220.2]:29637 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262976AbUC2PZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 10:25:55 -0500
Date: Mon, 29 Mar 2004 12:00:10 +0200
From: Andi Kleen <ak@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc32: Fix sector_t definition with CONFIG_LBD
Message-Id: <20040329120010.56bfcb4f.ak@suse.de>
In-Reply-To: <1080566303.1232.32.camel@gaston>
References: <1080541934.1210.5.camel@gaston>
	<20040328230351.1a0d0e9c.akpm@osdl.org>
	<p7365co848r.fsf@nielsen.suse.de>
	<1080566303.1232.32.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004 23:18:23 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> >  
> > -#ifdef CONFIG_LBD
> >  typedef u64 sector_t;
> >  #define HAVE_SECTOR_T
> > -#endif
> 
> Do you need that at all then ? The default unsigned long should
> be just fine...

True, it could be completely dropped too.

-Andi
