Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264994AbTGHGGz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 02:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbTGHGGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 02:06:55 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:18450 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264994AbTGHGGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 02:06:55 -0400
Date: Tue, 8 Jul 2003 07:21:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] new quota code
Message-ID: <20030708072126.A17566@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <200307072105.h67L50ir024592@hera.kernel.org> <3F09FC12.4070609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F09FC12.4070609@pobox.com>; from jgarzik@pobox.com on Mon, Jul 07, 2003 at 07:02:42PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 07, 2003 at 07:02:42PM -0400, Jeff Garzik wrote:
> > 	[1] This also mean completely dropping support for the interim ABI
> > 	used in the early 32bit quota patches as it's mutally incompatible
> > 	to the old ABI.  But we never ever shipped that in any mainline kernels
> > 	so there's no problem.
> 
> 
> "no problem" being defined here as "multiple vendors shipped it but I 
> don't care", right?

no problem as in this was neve supported in mainline and we don't need
to introduce a third quota ABI to official kernels.  The old ABI is
still supported and the 2.5 one in addition.

> Why do we need a third (fourth?) 2.4 quota abi/api floating around?

We don't.  We support the old one and the 2.5 one.

