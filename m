Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030643AbWJJXUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030643AbWJJXUR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 19:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbWJJXUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 19:20:16 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:62860 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030333AbWJJXUO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 19:20:14 -0400
Message-ID: <452C2AAA.5070001@austin.ibm.com>
Date: Tue, 10 Oct 2006 18:20:10 -0500
From: jschopp <jschopp@austin.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
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

The others look good, but this one complicates the code and doesn't have any benefit.  20 
for 21 isn't bad.
