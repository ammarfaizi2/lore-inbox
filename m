Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266013AbUEUUyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbUEUUyT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 16:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266020AbUEUUyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 16:54:19 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:2520 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S266013AbUEUUyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 16:54:18 -0400
Date: Fri, 21 May 2004 22:51:42 +0200
To: lcapitulino@prefeitura.sp.gov.br
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] drivers/block/floppy.c: Premature blk_queue_max_sectors()
Message-ID: <20040521205142.GA20588@mars>
References: <20040521195934.GA17681@mars> <20040521203320.GA1148@lorien.prodam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521203320.GA1148@lorien.prodam>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 05:33:20PM -0300, Luiz Fernando N. Capitulino wrote:
> Em Fri, May 21, 2004 at 09:59:34PM +0200, Arthur Othieno escreveu:
> | We're prematurely pampering the request queue before
> | checking whether it was indeed allocated successfully.
> | 
> | Against 2.6.6. Thanks.
> | 
> | 
> |  floppy.c |    2 +-
> |  1 files changed, 1 insertion(+), 1 deletion(-)
> |

snip

> I and Randy did a (long) audit for floppy init sometime ago. It includes
> your change. :-)
> 
>  I think the patch will be in next -mm.
 
Glad to hear that. It was beginning to look a little too scary ;)

	Arthur
