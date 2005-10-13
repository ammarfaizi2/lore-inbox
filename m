Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbVJMVce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbVJMVce (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 17:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbVJMVce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 17:32:34 -0400
Received: from colo.lackof.org ([198.49.126.79]:10667 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S964867AbVJMVcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 17:32:33 -0400
Date: Thu, 13 Oct 2005 15:39:27 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Russell King <rmk@arm.linux.org.uk>, Mikael Starvik <starvik@axis.com>,
       Ralf Baechle <ralf@linux-mips.org>, Matthew Wilcox <matthew@wil.cx>,
       Grant Grundler <grundler@parisc-linux.org>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@au.ibm.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@karaya.com>
Subject: Re: [PATCH 11/14] Big kfree NULL check cleanup - arch
Message-ID: <20051013213927.GA4912@colo.lackof.org>
References: <200510132129.40176.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510132129.40176.jesper.juhl@gmail.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2005 at 09:29:39PM +0200, Jesper Juhl wrote:
> This is the arch/ part of the big kfree cleanup patch.
> Remove pointless checks for NULL prior to calling kfree() in arch/.

> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

>  arch/parisc/kernel/ioctl32.c           |   32 +++++++++-----------------------

Looks good to me.

Signed-off-by: Grant Grundler <grundler@parisc-linux.org>

thanks,
grant
