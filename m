Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262919AbUC2NOS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbUC2NMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 08:12:05 -0500
Received: from dp.samba.org ([66.70.73.150]:684 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262919AbUC2NLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 08:11:07 -0500
Date: Mon, 29 Mar 2004 23:10:49 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc32: Fix sector_t definition with CONFIG_LBD
Message-ID: <20040329131048.GA27453@krispykreme>
References: <1080541934.1210.5.camel@gaston> <20040328230351.1a0d0e9c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328230351.1a0d0e9c.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 11:03:51PM -0800, Andrew Morton wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> >  sector_t depends on CONFIG_LBD but include/config.h may not be there
> >  thus causing interesting breakage in some places...
> 
> Nasty.

Dont forget trusty old linux/scripts/checkconfig.pl.

Anton
