Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbUC2NWG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbUC2NVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 08:21:22 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:38670 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262995AbUC2NTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 08:19:16 -0500
Date: Mon, 29 Mar 2004 14:19:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc32: Fix sector_t definition with CONFIG_LBD
Message-ID: <20040329141912.A13393@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <1080541934.1210.5.camel@gaston> <20040328230351.1a0d0e9c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040328230351.1a0d0e9c.akpm@osdl.org>; from akpm@osdl.org on Sun, Mar 28, 2004 at 11:03:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 11:03:51PM -0800, Andrew Morton wrote:
> >  Here's the fix for ppc32 (problem found by Roman Zippel, other archs
> >  need a similar fix).
> 
> Three of them.

Why do we keep thios in asm-*/types.h instead of linux/types.h, btw?
