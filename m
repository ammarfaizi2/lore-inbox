Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbSL3ANs>; Sun, 29 Dec 2002 19:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbSL3ANs>; Sun, 29 Dec 2002 19:13:48 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:63242 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262380AbSL3ANo>; Sun, 29 Dec 2002 19:13:44 -0500
Date: Mon, 30 Dec 2002 00:22:05 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Steven Barnhart <sbarn03@softhome.net>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vlsi_ir.h, add #define for KERNEL_VERSION
Message-ID: <20021230002205.A13560@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Barnhart <sbarn03@softhome.net>, alan@redhat.com,
	linux-kernel@vger.kernel.org
References: <1041207283.23364.6.camel@sbarn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1041207283.23364.6.camel@sbarn.net>; from sbarn03@softhome.net on Sun, Dec 29, 2002 at 07:14:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 07:14:38PM -0500, Steven Barnhart wrote:
> This patch defines (what seems to be missing) KERNEL_VERSION for the
> header file, include/net/irda/vlsi_ir.h to use. This fixes the bug that
> the compiler spits out saying "no binary before (" or something of the
> like. drivers/net/irda/vlsi_ir.c now compiles flawlessly.

What about including <linux/version.h> instead? :)

