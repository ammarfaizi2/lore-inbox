Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbULDXNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbULDXNb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 18:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbULDXNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 18:13:31 -0500
Received: from 4.Red-80-32-108.pooles.rima-tde.net ([80.32.108.4]:12672 "EHLO
	gimli") by vger.kernel.org with ESMTP id S261193AbULDXN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 18:13:28 -0500
Message-ID: <41B24542.7010803@sombragris.com>
Date: Sun, 05 Dec 2004 00:16:18 +0100
From: Miguel Angel Flores <maf@sombragris.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7xxx large integer
References: <41B222BE.9020205@sombragris.com>
In-Reply-To: <41B222BE.9020205@sombragris.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Angel Flores wrote:

> Hi all,
>
> I noticed a large integer warning when compiling 2.6.10rc3 with the 
> SCSI AIC-7xxx driver.
>
> Here is the patch.
>
> Cheers,
> MaF

I post the patch very quickly :(. The original code finally seems OK. My 
controller is not working with 39 bit addressing, although I can't find 
why the compiler warns. Maybe the length of dma_addr_t type, in the 
2.6.9 the type of the mask_39bit variable is bus_addr_t.

Forget the patch. I'll continue looking...

Thanks and excuse the inconvenience.

Cheers,
MaF

