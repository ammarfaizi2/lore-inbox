Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266808AbUIJKQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUIJKQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 06:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUIJKQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 06:16:48 -0400
Received: from the-village.bc.nu ([81.2.110.252]:57006 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266808AbUIJKQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 06:16:44 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: arjanv@redhat.com
Cc: Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <1094798428.2800.3.camel@laptop.fenrus.com>
References: <20040909232532.GA13572@taniwha.stupidest.org>
	 <1094798428.2800.3.camel@laptop.fenrus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094807650.17041.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 10:14:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-10 at 07:40, Arjan van de Ven wrote:
> Well I always assumed the future plan was to remove 8k stacks entirely;
> 4k+irqstacks and 8k basically have near comparable stack space, with
> this patch you create an option that has more but that is/should be
> deprecated. I'm not convinced that's a good idea.

Its probably appropriate to drop gcc 2.x support at that point too since
it's the major cause of remaining problems

