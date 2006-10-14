Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWJNCM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWJNCM0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 22:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbWJNCM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 22:12:26 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:51431 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752040AbWJNCMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 22:12:25 -0400
Message-ID: <45304771.70606@austin.ibm.com>
Date: Fri, 13 Oct 2006 21:12:01 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: akpm@osdl.org, jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>,
       netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 21/21]: powerpc/cell spidernet DMA coalescing
References: <20061010204946.GW4381@austin.ibm.com> <20061010212324.GR4381@austin.ibm.com>
In-Reply-To: <20061010212324.GR4381@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> The current driver code performs 512 DMA mappns of a bunch of 
> 32-byte structures. This is silly, as they are all in contiguous 
> memory. Ths patch changes the code to DMA map the entie area
> with just one call.
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Cc: James K Lewis <jklewis@us.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

While this patch wasn't useful in the current cell implementation of pci_map_single 
it sounds like people are going to be making changes to that sometime. In light of 
that new information (new to me anyway) this should probably go in after all.  Sorry 
for causing trouble.

Acked-by: Joel Schopp <jschopp@austin.ibm.com>

