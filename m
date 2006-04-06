Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWDFFOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWDFFOM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 01:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWDFFOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 01:14:12 -0400
Received: from ozlabs.org ([203.10.76.45]:59798 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750842AbWDFFOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 01:14:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17460.41871.587038.602053@cargo.ozlabs.ibm.com>
Date: Thu, 6 Apr 2006 15:13:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: anton@samba.org, alan@lxorguk.ukuu.org.uk, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Add prctl to change endian of a task
In-Reply-To: <20060403.154048.133638224.davem@davemloft.net>
References: <200604021637.49759.ioe-lkml@rameria.de>
	<1143989770.29060.28.camel@localhost.localdomain>
	<20060403223620.GC4704@krispykreme>
	<20060403.154048.133638224.davem@davemloft.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:

> Doesn't PPC have a PTE bit that does endian swapping?  Wouldn't
> that be easier to use for something like qemu?

Some embedded PPC chips do, but most PPCs don't.

Paul.
