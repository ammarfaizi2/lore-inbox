Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbWJKHQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbWJKHQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 03:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030676AbWJKHQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 03:16:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:46057 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030675AbWJKHQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 03:16:08 -0400
Subject: Re: [PATCH 21/21]: powerpc/cell spidernet DMA coalescing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: jschopp <jschopp@austin.ibm.com>
Cc: Linas Vepstas <linas@austin.ibm.com>, akpm@osdl.org, jeff@garzik.org,
       Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
In-Reply-To: <452C2AAA.5070001@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
	 <20061010212324.GR4381@austin.ibm.com>  <452C2AAA.5070001@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 17:15:10 +1000
Message-Id: <1160550910.6177.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 18:20 -0500, jschopp wrote:
> Linas Vepstas wrote:
> > The current driver code performs 512 DMA mappns of a bunch of 
> > 32-byte structures. This is silly, as they are all in contiguous 
> > memory. Ths patch changes the code to DMA map the entie area
> > with just one call.
> > 
> > Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> > Cc: James K Lewis <jklewis@us.ibm.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> 
> The others look good, but this one complicates the code and doesn't have any benefit.  20 
> for 21 isn't bad.

Hi Joel !

I'm not sure what you mean here.... (especially your 20 to 21 comment).

The patch looks perfectly fine to me, and in fact removes more lines of
code than it adds :)

Cheers,
Ben.


