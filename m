Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316258AbSGYSqP>; Thu, 25 Jul 2002 14:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSGYSqP>; Thu, 25 Jul 2002 14:46:15 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:23730 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316258AbSGYSqP>; Thu, 25 Jul 2002 14:46:15 -0400
Date: Thu, 25 Jul 2002 14:49:13 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020725144913.E8839@redhat.com>
References: <20020725110033.G2276@host110.fsmlabs.com> <20020725181126.A17859@infradead.org> <20020725112142.I2276@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020725112142.I2276@host110.fsmlabs.com>; from cort@fsmlabs.com on Thu, Jul 25, 2002 at 11:21:42AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 11:21:42AM -0600, Cort Dougan wrote:
> I'm glad you found it useful.
> 
> I'm sorry, Aunt Tillie has a mind of her own about indentation.  Patch
> below with spaces turned to tabs.

> +	if ( addr < PAGE_OFFSET )
> +	{

It looks like she still has to ready the Documentation/CodingStyle.  The 
space after the ( and before the ) are spurious, and thes { belongs on 
the same line as the if.

		-ben
